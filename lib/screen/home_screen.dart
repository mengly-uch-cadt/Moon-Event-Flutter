import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/state/event_state.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
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
  bool _allEventsLoading = true;
  List<GetEvent>? allEventsData;

  double halfScreen(BuildContext context) {
    return MediaQuery.of(context).size.width / 2.25;
  }

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  void getEvents() async {
    Future<ResponseResult> responseResult = eventService.getEvents(isAllEvents: true);
    final result = await responseResult;
    if (result.isSuccess) {
      allEventsData = result.data;
      ref.read(eventProvider.notifier).setAllEventData(allEventsData!);
    } else {
      throw Exception(result.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventState = ref.watch(eventProvider);
    final allEventsData = eventState.isAllEvents;

    // loading events
    _allEventsLoading = allEventsData == null;

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
                          onPressed: () {},
                          child: Text(
                            "See All",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    // Show skeleton or events based on loading state and data length
                    allEventsData == null || allEventsData.isEmpty
                        ? _buildNoDataMessage()  // Show 'No Available Data' if no events
                        : _buildEventsList(allEventsData),
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

  Widget _buildEventsList(List<GetEvent> events) {
    return Skeletonizer(
      enabled: _allEventsLoading,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: events.map((event) {
            return SizedBox(
              width: halfScreen(context),
              child: MoonEventCardWidget(
                imageUrl: event.imageUrl,
                title: event.title,
                description: event.description,
                location: event.location,
                date: event.date,
                time: event.time,
                numberParticipants: 0,
                category: event.category,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

}
