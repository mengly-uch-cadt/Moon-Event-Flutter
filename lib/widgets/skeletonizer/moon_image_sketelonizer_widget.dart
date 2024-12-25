import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MoonImageSketelonizerWidget extends StatelessWidget {
  const MoonImageSketelonizerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer(
      enabled: true,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image(image: AssetImage('assets/images/default-placeholder.jpg'), fit: BoxFit.cover),
      ),
    );
  }
}