import 'package:flutter/material.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/home/moon_carousel_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoonHomeScreen extends StatelessWidget {
  MoonHomeScreen({super.key});
  // Firestore collection reference
  final CollectionReference _counterRef =
      FirebaseFirestore.instance.collection('counter');  // Collection in Firestore
  
  final TextEditingController _controller = TextEditingController();

  // Add a new value to Firestore from the input field
  void _addInputValue(BuildContext context) async {
    String inputValue = _controller.text.trim();

    if (inputValue.isNotEmpty) {
      // Use `set()` if you want to update a specific document (e.g., for the same user)
      await _counterRef.doc('inputValuedddDoc').set({
        'inputValue': inputValue,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the input field after submitting
      _controller.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Please enter a value'), backgroundColor: AppColors.secondary,),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,  // Set background to transparent
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,  // Make the container fill the screen
        color: Colors.transparent,  // Ensure the container doesn't have the unwanted blue background
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const MoonCarouselWidget(),
              // Text input field
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter value',
                  ),
                ),
              ),
              // Submit button to add the input value to Firestore
              ElevatedButton(
                onPressed: () => _addInputValue(context),
                child: const Text('Submit Input'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
