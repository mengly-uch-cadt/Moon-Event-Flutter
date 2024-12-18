import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/state/event_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/utils/user_util.dart';
import 'package:moon_event/widgets/home/moon_carousel_widget.dart';
import 'package:moon_event/widgets/home/moon_list_category_widget.dart';
import 'package:moon_event/widgets/home/moon_title_see_all_widget.dart';
import 'package:moon_event/widgets/moon_event_list_widget.dart';
import 'package:moon_event/widgets/moon_no_event_data_message_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';
import 'package:moon_event/widgets/skeletonizer/moon_event_axis_skeletonizer_widget.dart';

class MoonHomeScreen extends ConsumerStatefulWidget {
  const MoonHomeScreen({super.key});

  @override
  ConsumerState<MoonHomeScreen> createState() => _MoonHomeScreenState();
}

class _MoonHomeScreenState extends ConsumerState<MoonHomeScreen> {
  EventService eventService = EventService();
  bool _allEventsLoading = false;
  bool _popluarEventsLoading = false;
  bool _newReleaseEventsLoading = false;
  List<GetEvent> allEventsData = [];
  List<GetEvent> popularEventsData= [];
  List<GetEvent> newReleaseEventsData= [];

  @override
  void initState() {
    super.initState();
    generateData();
    getPopularEvents();
    getNewReleaseEvents();
    getAllEvents();
    fetchUserData(ref);
  }

  void generateData()async{
    // for (var event in generatedEvents){
    //   Future<ResponseResult> responseResult = eventService.createEvent(event);
    //   final result = await responseResult;
    //   if(result.isSuccess){
    //     print('Event created${event.title}');
    //   }else{
    //     throw Exception('Failed to create event');
    //   }
    // }
  }

  void getPopularEvents() async {
    setState(() {
      _popluarEventsLoading = true;
    });
    Future<ResponseResult> responseResult = eventService.getEvents(isPopularEvents: true);
    final result = await responseResult;
    if (result.isSuccess) {
      if (result.data == null){
        setState(() {
          _popluarEventsLoading = false;
        });
        return;
      }
      ref.read(eventProvider.notifier).setPopularEventData(result.data!);
      setState(() {
        _popluarEventsLoading = false;
      });
    } else {
      ScaffoldMessenger(child: 
        SnackBar(
          content: Text(result.message),
          backgroundColor: AppColors.red,
        )
      );
    }
  }

  void getNewReleaseEvents() async {
    setState(() {
      _newReleaseEventsLoading = true;
    });
    Future<ResponseResult> responseResult = eventService.getEvents(isNewReleaseEvents: true);
    final result = await responseResult;
    if (result.isSuccess) {
      if (result.data == null){
        setState(() {
          _newReleaseEventsLoading = false;
        });
        return;
      }
      ref.read(eventProvider.notifier).setNewReleaseEventData(result.data!);
      setState(() {
        _newReleaseEventsLoading = false;
      });
    } else {
      throw Exception(result.message);
    }
  }
  
  void getAllEvents() async {
    setState(() {
      _allEventsLoading = true;
    });
    Future<ResponseResult> responseResult = eventService.getEvents(isAllEvents: true);
    final result = await responseResult;
    if (result.isSuccess) {
      if (result.data == null){
        setState(() {
          _allEventsLoading = false;
        });
        return;
      }
      ref.read(eventProvider.notifier).setAllEventData(result.data!);
      setState(() {
        _allEventsLoading = false;
      });
    } else {
      throw Exception(result.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventState = ref.watch(eventProvider);
    final allEventsData = eventState.allEvents ?? [];
    final popularEventsData = eventState.popularEvents ?? [];
    final newReleaseEventsData = eventState.newReleaseEvents ?? [];

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
                    MoonTitleSeeAllWidget(
                      firstTitle: "Popular",
                      secondTitle: "Events",
                      events: popularEventsData.isNotEmpty ? popularEventsData : [],
                    ),
                    // Show skeleton or events based on loading state and data length
                    _popluarEventsLoading 
                      ? const MoonEventAxisSkeletonizerWidget() // Show skeleton while loading
                      : (popularEventsData.isEmpty
                            ? const MoonNoEventDataMessageWidget() // Show 'No Available Data' if no events
                          : MoonEventListWidget(events: popularEventsData,)),

                    _popluarEventsLoading 
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                    MoonTitleSeeAllWidget(
                      firstTitle: "New",
                      secondTitle: "Events",
                      events: newReleaseEventsData.isNotEmpty ? newReleaseEventsData : [],
                    ),
                     // Show skeleton or events based on loading state and data length
                    _newReleaseEventsLoading
                      ? const MoonEventAxisSkeletonizerWidget() // Show skeleton while loading
                        : (newReleaseEventsData.isEmpty
                            ? const MoonNoEventDataMessageWidget() // Show 'No Available Data' if no events
                            : MoonEventListWidget(events: newReleaseEventsData,)),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Don't Miss Out!", style: Theme.of(context).textTheme.headlineMedium,), 
                        Text("Enroll now and take the first step towards mastering [subject/topic].", style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                    const SizedBox(height: 20),
                    // ===========================================================
                    // All Events
                    // ===========================================================
                    MoonTitleSeeAllWidget(
                      firstTitle: "All",
                      secondTitle: "Events",
                      events: allEventsData.isNotEmpty ? allEventsData : [],
                    ),
                    // Show skeleton or events based on loading state and data length
                    _allEventsLoading
                      ? const MoonEventAxisSkeletonizerWidget() // Show skeleton while loading
                        : (allEventsData.isEmpty
                            ? const MoonNoEventDataMessageWidget() // Show 'No Available Data' if no events
                            : MoonEventListWidget(events: allEventsData,)),
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
}
