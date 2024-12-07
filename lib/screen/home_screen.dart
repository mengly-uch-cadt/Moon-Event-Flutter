import 'dart:math';
import 'package:flutter/material.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
import 'package:moon_event/widgets/home/moon_carousel_widget.dart';
import 'package:moon_event/widgets/home/moon_list_category_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonHomeScreen extends StatelessWidget {
  const MoonHomeScreen({super.key});

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
