import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MoonProfileSkeletonizerWidget extends StatelessWidget {
  const MoonProfileSkeletonizerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer(
      enabled: true,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/default-placeholder.jpg'),
          radius: 50,
        ),
      ),
    );
  }
}