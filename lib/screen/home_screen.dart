import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
import 'package:moon_event/widgets/home/moon_carousel_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_event/widgets/home/moon_list_category_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

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

  double halfScreen(BuildContext context) {
    return MediaQuery.of(context).size.width / 2.25;
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
                    //  Popular Events  
                    // ===========================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MoonTitleWidget(
                          firstTitle: "Popular",
                          secondTitle: "Events",
                        ),
                        TextButton(onPressed: () {},
                        child: Text(
                          "See All", 
                          style: Theme.of(context).textTheme.bodyMedium
                          )
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: halfScreen(context),
                            child: MoonEventCardWidget(
                              imageUrl: '${(Random().nextInt(46) + 1)}',
                              title: 'Tech Conference 2024', 
                              description: 'A conference about the latest in technology.',
                              date: DateTime.now().add(Duration(days: Random().nextInt(30))),
                              time: const TimeOfDay(hour: 2, minute: 50),
                              category: 'Technology',
                              numberUsers: 0, 
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Don't Miss Out!", style: Theme.of(context).textTheme.headlineMedium,), 
                        Text("Enroll now and take the first step towards mastering [subject/topic].", style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                    const SizedBox(height: 20),
                    // ===========================================================
                    //  New Events  
                    // ===========================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MoonTitleWidget(
                          firstTitle: "New",
                          secondTitle: "Events",
                        ),
                        TextButton(onPressed: () {},
                        child: Text(
                          "See All", 
                          style: Theme.of(context).textTheme.bodyMedium
                          )
                        ),
                      ],
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: List.generate(4, (index) {
                    //       return SizedBox(
                    //         width: halfScreen(context),
                    //         child: MoonEventCardWidget(
                    //           imageUrl: '${(Random().nextInt(46) + 1)}',
                    //           title: 'Tech Conference 2024', 
                    //           description: 'A conference about the latest in technology.',
                    //           level: '',
                    //           rating: 0.0,
                    //           numberUsers: 0, 
                    //         ),
                    //       );
                    //     }),
                    //   ),
                    // ),
                    const SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Don't Miss Out!", style: Theme.of(context).textTheme.headlineMedium,), 
                        Text("Enroll now and take the first step towards mastering [subject/topic].", style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                    const SizedBox(height: 20),
                    // ===========================================================
                    //  All Events  
                    // ===========================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MoonTitleWidget(
                          firstTitle: "All",
                          secondTitle: "Events",
                        ),
                        TextButton(onPressed: () {},
                        child: Text(
                          "See All", 
                          style: Theme.of(context).textTheme.bodyMedium
                          )
                        ),
                      ],
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: List.generate(4, (index) {
                    //       return SizedBox(
                    //         width: halfScreen(context),
                    //         child: MoonEventCardWidget(
                    //           imageUrl: '${(Random().nextInt(46) + 1)}',
                    //           title: 'Tech Conference 2024', 
                    //           description: 'A conference about the latest in technology.',
                    //           date: DateTime.now().add(Duration(days: Random().nextInt(30))),
                    //           time: const TimeOfDay(hour: 2, minute: 50),
                    //           rating: 0.0,
                    //           numberUsers: 0, 
                    //         ),
                    //       );
                    //     }),
                    //   ),
                    // ),
                    const SizedBox(height: 20,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
