import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

const List<String> imageList = [
  '1.png',
  '2.png',
  '3.png',

];

const List<String> captions = [
  'First Image',
  'Second Image',
  'Third Image',
];

class MoonCarouselWidget extends StatelessWidget {
  const MoonCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          CarouselSlider.builder(
            itemCount: imageList.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                // margin: const EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5)],
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/banners/${imageList[index]}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              enableInfiniteScroll: true,
              initialPage: 0,
            ),
          ),
        ],
      );
  }
}
