import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:moon_event/theme.dart';

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

class MoonCarouselWidget extends StatefulWidget {
  const MoonCarouselWidget({super.key});

  @override
  State<MoonCarouselWidget> createState() => MoonCarouselWidgetState();
}

class MoonCarouselWidgetState extends State<MoonCarouselWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: imageList.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Container(
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
            autoPlayCurve: Curves.fastOutSlowIn,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.map((url) {
            int index = imageList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? AppColors.secondary
                    : AppColors.gray,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}