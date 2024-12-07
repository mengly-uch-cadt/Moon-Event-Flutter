import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moon_event/widgets/input/moon_date_picker_widget.dart';
import 'package:moon_event/widgets/input/moon_text_field_widget.dart';
import 'package:moon_event/widgets/input/moon_time_picker_widget.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonCreatedEventFormWidget extends StatefulWidget {
  const MoonCreatedEventFormWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MoonCreatedEventFormWidgetState createState() => _MoonCreatedEventFormWidgetState();
}

class _MoonCreatedEventFormWidgetState extends State<MoonCreatedEventFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _organizerIdController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  final TextEditingController _isPublicController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  final String _imageUrl = '${(Random().nextInt(46) + 1)}';
  @override
  Widget build(BuildContext context) {
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
                ),
                const SizedBox(height: 10),
                MoonTextFieldWidget(
                  controller: _descriptionController,
                  labelText: "Description",
                  hintText: "Enter the event description",
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
                ),
                const SizedBox(height: 10),
                MoonTextFieldWidget(
                  controller: _categoryController,
                  labelText: "Category",
                  hintText: "Enter the event category",
                ),
                const SizedBox(height: 10),
                Center(
                  child: MoonButtonWidget(
                    text: "Create Event",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Create a new event object
                      }
                    }
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
