import 'package:flutter/material.dart';
import 'package:moon_event/theme.dart';

class MoonTitleWidget extends StatelessWidget {
  const MoonTitleWidget({super.key, required this.firstTitle, required this.secondTitle, this.isTwoColors=true});
  final String firstTitle;
  final String secondTitle;
  final bool? isTwoColors;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          firstTitle.toUpperCase(), 
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          secondTitle.toUpperCase(), 
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: isTwoColors == true ? AppColors.primary : null,
          ),
        ),
      ],
    );
  }
}