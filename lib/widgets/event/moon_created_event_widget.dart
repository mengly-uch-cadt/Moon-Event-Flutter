import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/state/event_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/widgets/event/moon_created_event_form_widget.dart';
import 'package:moon_event/widgets/event/moon_event_grid_view_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonCreatedEventWidget extends ConsumerStatefulWidget {
  const MoonCreatedEventWidget({super.key});

  @override
  ConsumerState<MoonCreatedEventWidget> createState() => _MoonCreatedEventWidgetState();
}

class _MoonCreatedEventWidgetState extends ConsumerState<MoonCreatedEventWidget> {
  final ScrollController _scrollController = ScrollController();
  EventService eventService = EventService();
  bool _isBottom = false; // Track if the scroll is at the bottom
  List<GetEvent> userEventsData = []; // List of GetEvent objects

  @override
  void initState() {
    super.initState();
    getEventByUser();
    _scrollController.addListener(() {
      final isBottom = _scrollController.offset >= _scrollController.position.maxScrollExtent;
      if (isBottom != _isBottom) {
        setState(() {
          _isBottom = isBottom;
        });
      }
    });
  }

  void getEventByUser()async {
    Future<ResponseResult> responseResult = eventService.getEventsByUserUid();
    final result = await responseResult;
    if(result.isSuccess){
      userEventsData = result.data;
      ref.read(eventProvider.notifier).setUserEventData(userEventsData);
    }else{
      throw Exception('Failed to get events by user');
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventsData = ref.watch(eventProvider);
    final events = eventsData.userEvents ?? [];
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: 
            events.isEmpty 
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
                          const MoonTitleWidget(firstTitle: "Created", secondTitle: "Events"),
                          Text(
                            "Calendar",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    MoonEventGridViewWidget(events: events, scrollController: _scrollController,),
                  ],
                ),
              )
          ),
          if (!_isBottom) // Show the FAB only if not at the bottom
            Positioned(
              bottom: 16.0, // Adjust the vertical position
              right: 16.0, // Adjust the horizontal position
                child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (ctx)=> const MoonCreatedEventFormWidget(),
                  );
                },
                backgroundColor: AppColors.primary, // Set the background color
                focusColor: AppColors.primary,
                tooltip: 'Create New Event',
                child: Icon(Icons.add, color: AppColors.white,),
                ),
              ),
        ],
      ),
    );
  }
}
