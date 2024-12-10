import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:screenshot/screenshot.dart';

class MoonEventDetailsWidget extends StatefulWidget {
  const MoonEventDetailsWidget({
    super.key, 
    required this.event,
    this.isCreator = false,
  });
  final GetEvent event;
  final bool? isCreator;

  @override
  State<MoonEventDetailsWidget> createState() => _MoonEventDetailsWidgetState();
}

class _MoonEventDetailsWidgetState extends State<MoonEventDetailsWidget> {
  final ScreenshotController screenshotController = ScreenshotController();

  // Function to save QR code to gallery using saver_gallery
  Future<void> saveQRCode(String qrCodeData) async {
    // Request storage permission
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      // print("Permission denied");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission denied")),
      );
      return;
    }

    // Capture the QR code as an image
    final image = await screenshotController.capture();
    if (image == null) {
      // print("Failed to capture QR code.");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to capture QR code.")),
      );
      return;
    }

    // Save image to gallery using saver_gallery
    try {
      final result = await SaverGallery.saveImage(Uint8List.fromList(image), skipIfExists: true, fileName: 'qr_code_${qrCodeData}');
      if (result == true) {
        // ignore: avoid_print
        print("QR Code saved to gallery!");
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("QR Code saved to gallery!")),
        );
      } else {
        // print("Failed to save QR code.");
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to save QR code.")),
        );
      }
    } catch (e) {
      // print("Error saving QR code: $e");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving QR code: $e")),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MoonTitleWidget(firstTitle: "Event", secondTitle: "Details"),  ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
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
                            widget.event.imageUrl.isEmpty
                             ? Image.asset(
                              'assets/images/default-placeholder.jpg', // Default placeholder image
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 300,
                              )
                            : Image.asset(
                              'assets/images/${widget.event.imageUrl}.jpg',
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
                              widget.event.title,
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
                              widget.event.description,
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
                              "Location: ${widget.event.location}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            // ===========================================================
                            // Date & Time 
                            Row(
                              children: [
                                Text(
                                  DateFormat('MMM, dd, yyyy -' ).format(widget.event.date.toDate()),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${widget.event.startTime}-${widget.event.endTime}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // ===========================================================
                            // Category
                            Text(
                              widget.event.category.category,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            // ===========================================================
                            // Number of Participants
                            Text(
                              '${widget.event.participantCount} Participants',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              widget.isCreator!
                ? Column(
                  children: [
                    GestureDetector(
                      onLongPress: () => saveQRCode(widget.event.title),
                      child: Screenshot(
                        controller: screenshotController,
                        child: QrImageView(
                          data: widget.event.eventUuid, // UUID for QR code
                          size: 200.0, // QR code size
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Long press the QR code to save it",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                )
                : MoonButtonWidget(
                    text: "Attend",
                    onPressed: () async {
                      EventService eventService = EventService();
                      final responseResult =  await eventService.attendEvent(widget.event.eventUuid);
                      if(responseResult.isSuccess){
                        // ignore: use_build_context_synchronously
                        showDialog(context: context, builder: (ctx)=> 
                          MoonAlertWidget(
                            icon: Icons.check_circle_outline, 
                            title: 'Success',
                            description: responseResult.message,
                          )
                        );
                      }else{
                        // ignore: use_build_context_synchronously
                        showDialog(context: context, builder: (ctx)=> 
                          MoonAlertWidget(
                            icon: Icons.error_outline, 
                            title: "Error",
                            description: responseResult.message,
                            typeError: true,
                          )
                        );
                      }
                    },
                  ),
            ],
          ),
          
        ),
      ),
    );
  }
}