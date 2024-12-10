import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonEventDetailsWidget extends StatelessWidget {
  const MoonEventDetailsWidget({
    super.key, 
    required this.event
  });

  final GetEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MoonTitleWidget(firstTitle: "Event", secondTitle: "Details"),  ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
        child: SingleChildScrollView(
          child: Card(
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
                        event.imageUrl.isEmpty
                         ? Image.asset(
                          'assets/images/default-placeholder.jpg', // Default placeholder image
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 300,
                          )
                        : Image.asset(
                          'assets/images/${event.imageUrl}.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        )
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ===========================================================
                        // event.title
                        Text(
                          event.title,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
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
                        Text(
                          event.description,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
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
                        Text(
                          "Location: ${event.location}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        // ===========================================================
                        // Date & Time 
                        Row(
                          children: [
                            Text(
                              DateFormat('MMM, dd, yyyy -' ).format(event.date.toDate()),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${event.startTime}-${event.endTime}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // ===========================================================
                        // Category
                        Text(
                          event.category.category,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        // ===========================================================
                        // Number of Participants
                        Text(
                          '${event.participantCount} Participants',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

