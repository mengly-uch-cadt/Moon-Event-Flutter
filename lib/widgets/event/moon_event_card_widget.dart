
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moon_event/model/category.dart';
import 'package:moon_event/theme.dart';

class MoonEventCardWidget extends StatelessWidget {
  const MoonEventCardWidget({
    super.key, 
    required this.title, 
    required this.description, 
    required this.location,
    required this.date, 
    required this.time, 
    required this.category, 
    required this.numberParticipants, 
    this.imageUrl, 
  });

  final String title;
  final String description;
  final String location;
  final Timestamp date;
  final String time;
  final Category category;
  final int numberParticipants;
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
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ), 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                // ignore: unnecessary_null_comparison
                child: 
                  imageUrl == null
                  ?  Image.asset(
                      'assets/images/default-placeholder.jpg', // Default placeholder image
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 100,
                    )
                  : Image.asset(
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
                    height: 20,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2, // Maximum of 2 lines for the title
                      overflow: TextOverflow.ellipsis, // Ellipsis for long text
                    ),
                  ),
                  const SizedBox(height: 4),
                  Divider(
                    color: Colors.grey[300],
                    height: 0.5,
                  ),       
                  const SizedBox(height: 4),           
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
                  const SizedBox(height: 4),
                  Divider(
                    color: Colors.grey[300],
                    height: 0.5,
                  ), 
                  const SizedBox(height: 4),
                  // ===========================================================
                  // location
                  // SizedBox(
                  //   height: 40,
                  //   child: Text(
                  //     "Location: $location",
                  //       style: Theme.of(context).textTheme.bodySmall,
                  //     maxLines: 2, // Maximum of 2 lines for the title
                  //     overflow: TextOverflow.ellipsis, // Ellipsis for long text
                  //   ),
                  // ),
                  // const SizedBox(height: 4),
                  // ===========================================================
                  // Date & Time 
                  Row(
                    children: [
                      Text(
                        DateFormat('MMM, dd, yyyy -' ).format(date.toDate()),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  // const SizedBox(height: 4),
                  // ===========================================================
                  // Category
                  // Text(
                  //   category.category,
                  //   style: Theme.of(context).textTheme.bodySmall,
                  // ),
                  // const SizedBox(height: 4),
                  // ===========================================================
                  // Number of Participants
                  // Text(
                  //   '$numberParticipants Participants',
                  //   style: Theme.of(context).textTheme.bodySmall,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

