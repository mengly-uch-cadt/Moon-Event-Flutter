// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/state/event_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/widgets/event/moon_created_event_form_widget.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
import 'package:moon_event/widgets/event/moon_event_details_widget.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonCreatedEventWidget extends ConsumerStatefulWidget {
  const MoonCreatedEventWidget({super.key});

  @override
  ConsumerState<MoonCreatedEventWidget> createState() =>
      _MoonCreatedEventWidgetState();
}

class _MoonCreatedEventWidgetState
    extends ConsumerState<MoonCreatedEventWidget> {
  final ScrollController _scrollController = ScrollController();
  EventService eventService = EventService();
  bool _isBottom = false; // Track if the scroll is at the bottom
  bool _isLoading = false; // Track loading state
  List<GetEvent> userEventsData = []; // List of GetEvent objects
  final Set<String> selectedEventIds = {}; // Store IDs of selected events

  @override
  void initState() {
    super.initState();
    getEventByUser();
    _scrollController.addListener(() {
      final isBottom =
          _scrollController.offset >= _scrollController.position.maxScrollExtent;
      if (isBottom != _isBottom) {
        setState(() {
          _isBottom = isBottom;
        });
      }
    });
  }

  void getEventByUser() async {
    setState(() {
      _isLoading = true; // Start loading
    });
    try {
      Future<ResponseResult> responseResult = eventService.getEventsByUserUid();
      setState(() {
        _isLoading = false; // End loading
      });
      final result = await responseResult;
      if (result.data.isEmpty) {
        return;
      }
      if (result.isSuccess) {
        ref.read(eventProvider.notifier).setUserEventData(result.data);
      } else {
        throw Exception('Failed to get events by user');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // End loading
      });
    }
  }

  Future<void> deleteSelectedEvents() async {
    setState(() {
      _isLoading = true;
    });
    ResponseResult responseResult;
    try {
      responseResult = await eventService.deleteEvents(selectedEventIds);
      // Refresh event list
      getEventByUser();
      selectedEventIds.clear();
      if (responseResult.isSuccess){
        showDialog(
          context: context,
          builder: (ctx) => MoonAlertWidget(
            icon: Icons.check_circle_outline,
            title: 'Success',
            description: responseResult.message,
            typeError: false,
          ),
        );
      }else{
        showDialog(context: context, builder: 
          (ctx) => MoonAlertWidget(
            icon: Icons.error_outline, 
            title:  'Error', 
            description: responseResult.message
          )
        );
      }
    } catch (e) {
      showDialog(context: context, builder: 
        (ctx) => MoonAlertWidget(
          icon: Icons.error_outline, 
          title:  'Error', 
          description: e.toString()
        )
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
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
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : events.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.event,
                                size: 100, color: AppColors.gray),
                            const SizedBox(height: 16),
                            Text(
                              'No events found',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const MoonTitleWidget(
                                    firstTitle: "Created",
                                    secondTitle: "Events"),
                                Text(
                                  "Calendar",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          if (selectedEventIds.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${selectedEventIds.length} selected',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                IconButton(
                                  onPressed: deleteSelectedEvents, 
                                  icon: const Icon(Icons.delete),
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          Expanded(
                            child: GridView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Display two cards per row
                                childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.5), // Adjust this ratio to fit your card size dynamically
                              ),
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                final event = events[index];
                                final isSelected =
                                    selectedEventIds.contains(event.eventUuid);
                                return GestureDetector(
                                  onTap: selectedEventIds.isNotEmpty
                                      ? () {
                                          setState(() {
                                            if (isSelected) {
                                              selectedEventIds.remove(event.eventUuid);
                                            } else {
                                              selectedEventIds.add(event.eventUuid);
                                            }
                                          });
                                        }
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MoonEventDetailsWidget(
                                                      event: event,
                                                      isCreator: true),
                                            ),
                                          );
                                        },
                                  onLongPress: () {
                                    setState(() {
                                      selectedEventIds.add(event.eventUuid);
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      MoonEventCardWidget(
                                        event: event,
                                        isCreator: true,
                                      ),
                                      if (isSelected)
                                        Positioned.fill(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              color: Colors.black
                                                  .withOpacity(0.5),
                                              child: const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 48,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
          ),
          if (!_isBottom)
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => const MoonCreatedEventFormWidget(),
                  );
                },
                backgroundColor: AppColors.primary,
                tooltip: 'Create New Event',
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
