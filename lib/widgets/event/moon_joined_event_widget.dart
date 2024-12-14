import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/state/event_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/widgets/event/moon_event_grid_view_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonJoinedEventWidget extends ConsumerStatefulWidget {
  const MoonJoinedEventWidget({super.key});

  @override
  ConsumerState<MoonJoinedEventWidget> createState() => _MoonJoinedEventWidgetState();
}

class _MoonJoinedEventWidgetState extends ConsumerState<MoonJoinedEventWidget> {
  EventService eventService = EventService();
  @override
  void initState() {
    super.initState();
    getJoinedEvents();
  }

  Future<void> getJoinedEvents() async {
    Future<ResponseResult> responseResult = eventService.getJoinedEvents();
    final result = await responseResult;
    if(result.isSuccess){
      var joinedEventsData = result.data;
      ref.read(eventProvider.notifier).setJoinedEventData(joinedEventsData);
    }else{
      throw Exception('Failed to get events by user');
    }
  }
  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventProvider);
    final eventsData = events.joinedEvents ?? [];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          // child: Text("Register Event"),
          child: 
            eventsData.isEmpty 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.event, size: 100, color: AppColors.gray),
                      const SizedBox(height: 16),
                      Text(
                        'No events found',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MoonTitleWidget(firstTitle: "Register", secondTitle: "Events"),
                          Text(
                            "Calendar",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    MoonEventGridViewWidget(events: eventsData),
                    const SizedBox(height: 20,)
                  ],
                ),
              )
          
        ),
      )
    );
  }
}
