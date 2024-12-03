import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moon_event/widgets/home/moon_carousel_widget.dart';

class MoonHomeScreen extends StatelessWidget {
  const MoonHomeScreen({super.key});
   

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          MoonCarouselWidget(),
        ],
      ),
    );
  }
}