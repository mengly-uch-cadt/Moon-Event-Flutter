import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/main.dart';
import 'package:moon_event/model/event.dart';
import 'package:moon_event/model/get_user.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/services/user_service.dart';
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
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final String _imageUrl = '${(Random().nextInt(46) + 1)}';
  String? _selectedCategoryId;
  bool isPublic = false;
  bool _isLoading = false;
  List<GetUser> users = [];

  // For selected participants (User IDs)
  List<String> selectedUIDs = [];

  @override
  void initState() {
    super.initState();
    getUserMap();
  }

  void handleToggle(bool value) {
    setState(() {
      isPublic = value;
    });
  }

  void getUserMap() {
    UserService userService = UserService();
    userService.getUsers().then((responseResult) {
      if (responseResult.isSuccess) {
        setState(() {
          users = responseResult.data;
          ref.read(getUsersProvider.notifier).setGetUsersData(users);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final usersData = ref.watch(getUsersProvider);
    final categories = ref.watch(categoryProvider);
    final user = ref.watch(userProvider);
    final userUid = user?.uid;

    void handleParticipantsChange(List<String> participants) {
      setState(() {
        selectedUIDs = participants;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const MoonTitleWidget(firstTitle: "Create", secondTitle: "Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: 
          user == null
              ? const Center(child: CircularProgressIndicator())
              :Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Field
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
                    // Description Field
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
                    // Date and Time Fields
                    MoonDatePickerWidget(
                      controller: _dateController,
                      labelText: "Date",
                      hintText: "Select a date",
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a date";
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MoonTimePickerWidget(
                          controller: _startTimeController,
                          labelText: "Start Time",
                          hintText: "Select the event time",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select a time.";
                            }
                            return null;
                          },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: MoonTimePickerWidget(
                          controller: _endTimeController,
                          labelText: "End Time",
                          hintText: "Select the event time",
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
                    // Location Field
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
                    // Category Dropdown
                    MoonDropdownInputWidget(
                      value: _selectedCategoryId,
                      items: categories,
                      labelText: "Category",
                      hintText: "Select a category",
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategoryId = newValue;
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
                    // Participants Input
                    MoonEmailParticipantsInputWidget(
                      userList: usersData!,
                      onParticipantsChanged: handleParticipantsChange,
                    ),
                    const SizedBox(height: 10),
                    // Public Event Toggle
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
                    // Submit Button
                    Center(
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : MoonButtonWidget(
                              text: "Create Event",
                              onPressed: _isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        try {
                                          final event = Event(
                                            title                 : _titleController.text,
                                            description           : _descriptionController.text,
                                            date                  : DateTime.parse(_dateController.text),
                                            startTime             : _startTimeController.text,
                                            endTime               : _endTimeController.text,
                                            location              : _locationController.text,
                                            imageUrl              : _imageUrl,
                                            organizerId           : userUid!,
                                            participantsRegistered: selectedUIDs,
                                            participantsJoined    : [],
                                            isPublic              : isPublic,
                                            categoryId            : _selectedCategoryId!,
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
                                              Navigator.pushReplacement(
                                                // ignore: use_build_context_synchronously
                                                context,
                                                MaterialPageRoute(builder: (context) => const MyApp()),
                                              );
                                            });
                                          } else {
                                            showDialog(
                                              // ignore: use_build_context_synchronously
                                              context: context,
                                              builder: (ctx) => const MoonAlertWidget(
                                                icon: Icons.error_outline,
                                                title: 'Error',
                                                description: 'Failed to create the event. Please try again.',
                                                typeError: true,
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          showDialog(
                                            // ignore: use_build_context_synchronously
                                            context: context,
                                            builder: (ctx) => const MoonAlertWidget(
                                              icon: Icons.error_outline,
                                              title: 'Error',
                                              description: 'An unexpected error occurred. Please try again.',
                                              typeError: true,
                                            ),
                                          );
                                        } finally {
                                          setState(() {
                                            _isLoading = false;
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
