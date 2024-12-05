import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon_event/theme.dart';

class MoonListCategoryWidget extends StatelessWidget {
  const MoonListCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.white, // Background color
        borderRadius: BorderRadius.circular(8), // Border radius of 8
        border: Border.all(
          color: Colors.grey.shade300, // Border color
          width: 0.5, // Border width of 0.5
        ),
        boxShadow: const [], // Remove shadows by providing an empty list
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        children: [
          for (var i = 0; i < 6; i++) itemBuilder(context, i),
        ],
      ),
    );
  }
}

class TgiCategory extends StatelessWidget {
  const TgiCategory({super.key, required this.category, required this.icon});
  final String category;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final category = this.category.split(" ");
    return SizedBox(
      width: 80, // Adjust width if necessary
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            width: 50,
            height: 50,
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/$icon.svg',
                // ignore: deprecated_member_use
                color: AppColors.white,
                width: 25,
                height: 25,
              ),
            ),
          ),
          const SizedBox(height: 8), // Space between icon and text
          Column(
            children: [
              Text(
                category[0],
                textAlign: TextAlign.center, // Center-align the text
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2, // Allow up to 2 lines for wrapping
                overflow: TextOverflow.ellipsis, // Handle overflow gracefully
              ),
              Text(
                category[1],
                textAlign: TextAlign.center, // Center-align the text
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2, // Allow up to 2 lines for wrapping
                overflow: TextOverflow.ellipsis, // Handle overflow gracefully
              ),
            ],
          )
          
        ],
      ),
    );
  }
}

Widget itemBuilder(BuildContext context, int index) {
  const categories = [
    TgiCategory(category: 'Cyber Security', icon: 'security-lock'),
    TgiCategory(category: 'Artificial Intelligence', icon: 'bug-fill'),
    TgiCategory(category: 'Data Science', icon: 'data-science'),
    TgiCategory(category: 'UI/UX Design', icon: 'ui-ux-design'),
    TgiCategory(category: 'Digital Marketing', icon: 'digital-marketing'),
    TgiCategory(category: 'Web/App Development', icon: 'web-development'),
    TgiCategory(category: 'Fintech', icon: 'fintech'),
  ];
  return categories[index];
}
