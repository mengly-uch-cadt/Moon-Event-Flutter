
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/moon_divider_widget.dart';

class MoonEventCardWidget extends StatelessWidget {
  const MoonEventCardWidget({super.key, required this.title, required this.description, required this.date, required this.time, required this.category, required this.numberUsers, this.imageUrl});

  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final String category;
  final int numberUsers;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ), 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                // ignore: unnecessary_null_comparison
                child: Image.asset(
                  'assets/images/$imageUrl.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 100,
                )
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===========================================================
                  // Title
                  SizedBox(
                    height: 40,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2, // Maximum of 2 lines for the title
                      overflow: TextOverflow.ellipsis, // Ellipsis for long text
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    height: 0.5,
                  ),                  
                  // ===========================================================
                  // Description
                  SizedBox(
                    height: 40,
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2, // Maximum of 2 lines for the title
                      overflow: TextOverflow.ellipsis, // Ellipsis for long text
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    height: 0.5,
                  ), 
                  // ===========================================================
                  // Date & Time 
                  Row(
                    children: [
                      Text(
                        '${date.day}/${date.month}/${date.year}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time.format(context),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // ===========================================================
                  // Category
                  Row( 
                    children: [
                      SvgPicture.asset(
                        'assets/icons/web-development.svg',
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

