import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/state/event_state.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/widgets/event/moon_created_event_form_widget.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
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
      appBar: AppBar(
        title: const MoonTitleWidget(firstTitle: "Created", secondTitle: "Events"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Calendar",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
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
              : GridView.builder(
                  controller: _scrollController,
                  shrinkWrap: true, // Prevent the GridView from taking up all available space
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Display two cards per row
                    childAspectRatio: 0.58, // Adjust this ratio to fit your card size
                  ),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return MoonEventCardWidget(
                      imageUrl: event.imageUrl,
                      title: event.title,
                      description: event.description,
                      location: event.location,
                      date: event.date,
                      time: event.time,
                      numberParticipants: event.participants.length,
                      category: event.category,
                    );
                  },
                ),
          ),
          if (!_isBottom) // Show the FAB only if not at the bottom
            Positioned(
              bottom: 16.0, // Adjust the vertical position
              right: 16.0, // Adjust the horizontal position
                child: FloatingActionButton(
                onPressed: () {
                  if (ref.read(userProvider) == null) {
                    showDialog(context: context, builder: (ctx) => 
                      const MoonAlertWidget(
                        icon: Icons.error_outline,
                        title: 'Error',
                        description: 'Please log in to create an event.',
                        typeError: true,
                      ));
                    return;
                  }
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
