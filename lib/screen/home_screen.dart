import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/category.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/model/user.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/services/user_service.dart';
import 'package:moon_event/state/event_state.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/utils/secure_local_storage_util.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
import 'package:moon_event/widgets/event/moon_see_all_event_widget.dart';
import 'package:moon_event/widgets/home/moon_carousel_widget.dart';
import 'package:moon_event/widgets/home/moon_list_category_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MoonHomeScreen extends ConsumerStatefulWidget {
  const MoonHomeScreen({super.key});

  @override
  ConsumerState<MoonHomeScreen> createState() => _MoonHomeScreenState();
}

class _MoonHomeScreenState extends ConsumerState<MoonHomeScreen> {
  EventService eventService = EventService();
  UserService userService = UserService();
  bool _allEventsLoading = true;
  bool _popluarEventsLoading = true;
  bool _newReleaseEventsLoading = true;
  List<GetEvent>? allEventsData;
  List<GetEvent>? popularEventsData;
  List<GetEvent>? newReleaseEventsData;

  double halfScreen(BuildContext context) {
    return MediaQuery.of(context).size.width / 2.25;
  }

  @override
  void initState() {
    super.initState();
    getPopularEvents();
    getNewReleaseEvents();
    getAllEvents();
    fetchUserData();
  }

  void getPopularEvents() async {
    Future<ResponseResult> responseResult = eventService.getEvents(isPopularEvents: true);
    final result = await responseResult;
    if (result.isSuccess) {
      popularEventsData = result.data;
      ref.read(eventProvider.notifier).setPopularEventData(popularEventsData!);
    } else {
      throw Exception(result.message);
    }
  }

  void getNewReleaseEvents() async {
    Future<ResponseResult> responseResult = eventService.getEvents(isNewReleaseEvents: true);
    final result = await responseResult;
    if (result.isSuccess) {
      newReleaseEventsData = result.data;
      ref.read(eventProvider.notifier).setNewReleaseEventData(newReleaseEventsData!);
    } else {
      throw Exception(result.message);
    }
  }
  
  void getAllEvents() async {
    Future<ResponseResult> responseResult = eventService.getEvents(isAllEvents: true);
    final result = await responseResult;
    if (result.isSuccess) {
      allEventsData = result.data;
      ref.read(eventProvider.notifier).setAllEventData(allEventsData!);
    } else {
      throw Exception(result.message);
    }
  }

  void fetchUserData() async {
    final String? userUid = await getUserId();
    if (userUid == null) {
      throw Exception('User ID is null');
    }
    Future<ResponseResult> responseResult = userService.getUserByUid(userUid);
    responseResult.then((responseResult) {
      if (responseResult.isSuccess) {
        final User user = responseResult.data;
        ref.read(userProvider.notifier).setUserData(user);
      } else {
        throw Exception('Failed to get user data');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final eventState = ref.watch(eventProvider);
    final allEventsData = eventState.allEvents;
    final popularEventsData = eventState.popularEvents;
    final newReleaseEventsData = eventState.newReleaseEvents;

    // loading events
    _allEventsLoading = allEventsData == null;
    _popluarEventsLoading = popularEventsData == null;
    _newReleaseEventsLoading = newReleaseEventsData == null;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const MoonCarouselWidget(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MoonTitleWidget(firstTitle: "Explore", secondTitle: "Our Categories"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const MoonListCategoryWidget(),
                    const SizedBox(height: 20),
                    // ===========================================================
                    // Popular Events  
                    // ===========================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MoonTitleWidget(
                          firstTitle: "Popular",
                          secondTitle: "Events",
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "See All", 
                            style: Theme.of(context).textTheme.bodyMedium
                          )
                        ),
                      ],
                    ),
                    // Show skeleton or events based on loading state and data length
                    _popluarEventsLoading
                      ? _buildSkeleton() // Show skeleton while loading
                      : (popularEventsData == null || popularEventsData.isEmpty
                          ? _buildNoDataMessage()  // Show 'No Available Data' if no events
                          : _buildEventsList(popularEventsData, _popluarEventsLoading)),
                    _popluarEventsLoading 
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Don't Miss Out!", style: Theme.of(context).textTheme.headlineMedium,), 
                          Text("Check out the most popular events happening right now. Don't miss the chance to be part of these exciting experiences!", style: Theme.of(context).textTheme.bodyMedium,)
                        ],
                      )
                      : const SizedBox(),
                    const SizedBox(height: 20),
                    // ===========================================================
                    //  New Events  
                    // ===========================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MoonTitleWidget(
                          firstTitle: "New",
                          secondTitle: "Events",
                        ),
                        TextButton(onPressed: () {},
                        child: Text(
                          "See All", 
                          style: Theme.of(context).textTheme.bodyMedium
                          )
                        ),
                      ],
                    ),
                     // Show skeleton or events based on loading state and data length
                    _newReleaseEventsLoading
                        ? _buildSkeleton() // Show skeleton while loading
                        : (newReleaseEventsData == null || newReleaseEventsData.isEmpty
                            ? _buildNoDataMessage()  // Show 'No Available Data' if no events
                            : _buildEventsList(newReleaseEventsData, _newReleaseEventsLoading)),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Don't Miss Out!", style: Theme.of(context).textTheme.headlineMedium,), 
                        Text("Enroll now and take the first step towards mastering [subject/topic].", style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                    const SizedBox(height: 20),
                    // ===========================================================
                    // All Events
                    // ===========================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MoonTitleWidget(
                          firstTitle: "All",
                          secondTitle: "Events",
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (ctx)=> MoonSeeAllEventWidget(events: allEventsData!, moonTitleWidget: const MoonTitleWidget(firstTitle: "All", secondTitle: "Events"),)
                            );
                          },
                          child: Text(
                            "See All",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    // Show skeleton or events based on loading state and data length
                    _allEventsLoading
                        ? _buildSkeleton() // Show skeleton while loading
                        : (allEventsData == null || allEventsData.isEmpty
                            ? _buildNoDataMessage()  // Show 'No Available Data' if no events
                            : _buildEventsList(allEventsData, _allEventsLoading)),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to show the skeleton loader while fetching data
  Widget _buildSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(3, (index) {
            return SizedBox(
              width: halfScreen(context),
              child: MoonEventCardWidget(
                imageUrl: null,
                title: 'Loading...',
                description: 'Loading...',
                location: 'Loading...',
                date: Timestamp.now(),
                time: 'Loading...',
                numberParticipants: 0,
                category: Category(
                  uuid: 'uuid-placeholder',
                  category: 'category-placeholder',
                  icon: "", // replace with appropriate icon
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // Widget to show the "No Available Data" message when no events are present
  Widget _buildNoDataMessage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'No available events.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildEventsList(List<GetEvent> events, bool enabled) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: events.map((event) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context, 
                builder: (ctx)=> 
                  MoonSeeAllEventWidget(
                    events: events, 
                    moonTitleWidget: const MoonTitleWidget(
                      firstTitle: "All", 
                      secondTitle: "Events"
                    ),
                  )
              );
            },
            child: SizedBox(
              width: halfScreen(context),
              child: MoonEventCardWidget(
                imageUrl: event.imageUrl,
                title: event.title,
                description: event.description,
                location: event.location,
                date: event.date,
                time: event.time,
                numberParticipants: event.participants.length,
                category: event.category,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
