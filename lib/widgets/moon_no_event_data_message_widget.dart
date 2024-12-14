import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoonNoEventDataMessageWidget extends StatelessWidget {
  const MoonNoEventDataMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/monkey.svg'
            ),
            Text(
              'No available events.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}