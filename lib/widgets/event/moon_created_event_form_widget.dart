import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/main.dart';
import 'package:moon_event/model/event.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/state/category_state.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/widgets/input/moon_date_picker_widget.dart';
import 'package:moon_event/widgets/input/moon_dropdown_input_widget.dart';
import 'package:moon_event/widgets/input/moon_email_participants_input_widget.dart';
import 'package:moon_event/widgets/input/moon_text_field_widget.dart';
import 'package:moon_event/widgets/input/moon_time_picker_widget.dart';
import 'package:moon_event/widgets/input/moon_toggle_button.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonCreatedEventFormWidget extends ConsumerStatefulWidget {
  const MoonCreatedEventFormWidget({super.key});

  @override
  ConsumerState<MoonCreatedEventFormWidget> createState() =>
      _MoonCreatedEventFormWidgetState();
}

class _MoonCreatedEventFormWidgetState extends ConsumerState<MoonCreatedEventFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final String _imageUrl = '${(Random().nextInt(46) + 1)}';
  // Track the selected category id
  String? _selectedCategoryId;
  bool isPublic = false;
  bool _isLoading = false;

  void handleToggle(bool value) {
    setState(() {
      isPublic = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    // Watch the category provider here to get the categories
    final categories = ref.watch(categoryProvider);
    final user = ref.watch(userProvider);
    final userUid = user?.uid;

    

    final Map<String, String> userMap = {
      'uid1': 'john.doe@example.com',
      'uid2': 'jane.smith@example.com',
      'uid3': 'alice.wonderland@example.com',
      'uid4': 'bob.builder@example.com',
    }; // Replace with data fetched from Firebase


    List<String> selectedUIDs = [];

    void handleParticipantsChange(List<String> participants) {
      setState(() {
        selectedUIDs = participants;
      });
    }
    // =================================================================== 
    return Scaffold(
      appBar: AppBar(
        title: const MoonTitleWidget(firstTitle: "Create", secondTitle: "Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoonTextFieldWidget(
                  controller: _titleController,
                  labelText: "Title",
                  hintText: "Enter the event title",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the event title";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MoonTextFieldWidget(
                  controller: _descriptionController,
                  labelText: "Description",
                  hintText: "Enter the event description",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the event description";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MoonDatePickerWidget(
                        controller: _dateController,
                        labelText: "Date", // Label inside the input
                        hintText: "Select a date", // Placeholder text
                        firstDate: DateTime(2000), // Date range start
                        lastDate: DateTime(2100), // Date range end
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a date";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10), // Add spacing between the widgets
                    Expanded(
                      child: MoonTimePickerWidget(
                        controller: _timeController,
                        labelText: "Time", // Label inside the input
                        hintText: "Select the event time", // Placeholder text
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a time.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                MoonTextFieldWidget(
                  controller: _locationController,
                  labelText: "Location",
                  hintText: "Enter the event location",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the event location";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Use categories data here with the selected category id
                MoonDropdownInputWidget(
                  value: _selectedCategoryId, // Pass the selected category id
                  items: categories, // Pass the categories data
                  labelText: "Category",
                  hintText: "Select a category",
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategoryId = newValue; // Update the selected id
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a category";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MoonEmailParticipantsInputWidget(
                  userMap: userMap, 
                  onParticipantsChanged: handleParticipantsChange
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Public Event"),
                    const SizedBox(width: 10),
                    MoonToggleButton(
                      initialValue: isPublic,
                      onChanged: handleToggle,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.white,
                    ),
                  ],
                ),
                
                const SizedBox(height: 10),
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator() // Show a loading spinner when loading
                      : MoonButtonWidget(
                          text: "Create Event",
                          onPressed: _isLoading
                              ? null // Disable the button when loading
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true; // Start loading
                                    });

                                    try {
                                      // Create a new event object using the selected category ID
                                      final event = Event(
                                        title: _titleController.text,
                                        description: _descriptionController.text,
                                        date: DateTime.parse(_dateController.text),
                                        time: _timeController.text,
                                        location: _locationController.text,
                                        imageUrl: _imageUrl,
                                        organizerId: userUid!,
                                        participants: selectedUIDs,
                                        isPublic: isPublic,
                                        categoryId: _selectedCategoryId!,
                                      );

                                      EventService eventService = EventService();

                                      ResponseResult responseResult = await eventService.createEvent(event);

                                      if (responseResult.isSuccess) {
                                        showDialog(
                                          // ignore: use_build_context_synchronously
                                          context: context,
                                          builder: (ctx) => MoonAlertWidget(
                                            icon: Icons.check_circle_outline,
                                            title: 'Success',
                                            description: responseResult.message,
                                            typeError: false,
                                          ),
                                        ).then((value) {
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => const MyApp()),
                                          );
                                        });
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        showDialog( context: context,
                                          builder: (ctx) => const MoonAlertWidget(
                                            icon: Icons.error_outline,
                                            title: 'Error',
                                            description: 'Failed to create the event. Please try again.',
                                            typeError: true,
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      // Handle unexpected errors
                                      // ignore: use_build_context_synchronously
                                      showDialog( context: context,
                                        builder: (ctx) => const MoonAlertWidget(
                                          icon: Icons.error_outline,
                                          title: 'Error',
                                          description: 'An unexpected error occurred. Please try again.',
                                          typeError: true,
                                        ),
                                      );
                                    } finally {
                                      setState(() {
                                        _isLoading = false; // Stop loading
                                      });
                                    }
                                  }
                                },
                        ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
