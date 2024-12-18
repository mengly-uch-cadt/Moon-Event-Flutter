// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/state/event_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
import 'package:moon_event/widgets/event/moon_event_details_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonRegisterEventWidget extends ConsumerStatefulWidget {
  const MoonRegisterEventWidget({super.key});

  @override
  ConsumerState<MoonRegisterEventWidget> createState() => _MoonRegisterEventWidgetState();
}

class _MoonRegisterEventWidgetState extends ConsumerState<MoonRegisterEventWidget> {
  EventService eventService = EventService();
  bool isLoadingRegister = false;
  @override
  void initState() {
    super.initState();
    getRegisterEvents();
  }

  Future<void> getRegisterEvents() async {
    setState(() {
      isLoadingRegister = true; // Start loading
    });
    try{
      Future<ResponseResult> responseResult = eventService.getRegisterEvents();
      final result = await responseResult;
      if(result.isSuccess){
        var registerEventsData = result.data;
        ref.read(eventProvider.notifier).setRegisterEventData(registerEventsData);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: AppColors.red ,
          ),
        );
      }

    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.red ,
        ),
      );
    } finally{
      isLoadingRegister = false;
    }
  }


 @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventProvider);
    final eventsData = events.registerEvents ?? [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: 
            isLoadingRegister == true ? 
            const SizedBox(
              height: 60.0, // Set the desired height
              width: 60.0,  // Set the desired width
              child: CircularProgressIndicator(),
            )
            : eventsData.isEmpty 
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
              : Column(
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
                    Expanded( // Ensures the GridView fills the remaining space
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Display two cards per row
                          childAspectRatio: 0.65, // Adjust this ratio to fit your card size
                        ),
                        itemCount: eventsData.length,
                        itemBuilder: (context, index) {
                          final event = eventsData[index];
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context, 
                                builder: (ctx) => MoonEventDetailsWidget(event: event, isCreator: false),
                              );
                            },
                            child: MoonEventCardWidget(
                              event: event,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

}