// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, prefer_typing_uninitialized_variables

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/event/moon_created_event_form_widget.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';
import 'package:moon_event/widgets/profile/moon_login_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:screenshot/screenshot.dart';

class MoonEventDetailsWidget extends ConsumerStatefulWidget {
  const MoonEventDetailsWidget({
    super.key,
    required this.event,
    this.isCreator = false,
    this.registerMode = true,
  });
  final GetEvent event;
  final bool? isCreator;
  final bool? registerMode;

  @override
  ConsumerState<MoonEventDetailsWidget> createState() => _MoonEventDetailsWidgetState();
}

class _MoonEventDetailsWidgetState extends ConsumerState<MoonEventDetailsWidget> {
  final ScreenshotController screenshotController = ScreenshotController();
  late final user;
  bool registerSuccess = false;
  bool joinSuccess = false;

  // Function to save QR code to gallery using saver_gallery
  Future<void> saveQRCode(String qrCodeData) async {
    // Request storage permission
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission denied")),
      );
      return;
    }

    // Capture the QR code as an image
    final image = await screenshotController.capture();
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to capture QR code.")),
      );
      return;
    }

    // Save image to gallery using saver_gallery
    try {
      final result = await SaverGallery.saveImage(Uint8List.fromList(image), skipIfExists: true, fileName: 'qr_code_$qrCodeData');
      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("QR Code saved to gallery!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to save QR code.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving QR code: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    user = ref.read(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    
    // watch the user state
    final currentUser = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const MoonTitleWidget(firstTitle: "Event", secondTitle: "Details"),
        actions: [
          if (widget.isCreator!)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => MoonCreatedEventFormWidget(
                    event: widget.event,
                    isEdit: true,
                  ),
                );
              },

            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                          child: widget.event.imageUrl.isEmpty
                              ? AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.asset(
                                    'assets/images/default-placeholder.jpg', // Default placeholder image
                                    fit: BoxFit.cover,
                                  ),
                              )
                              : widget.event.imageUrl.startsWith('http') 
                                ? AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.network(
                                      widget.event.imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  )
                                : AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.asset(
                                        'assets/images/${widget.event.imageUrl}.jpg',
                                        fit: BoxFit.cover,
                                      ),
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
                                  DateFormat('MMM, dd, yyyy -').format(widget.event.date.toDate()),
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
                            if(widget.isCreator!)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ===========================================================
                                  // Number of Participants
                                  Text(
                                    '${widget.event.participantsRegistered.length} Participants registered',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${widget.event.participantsJoined.length} Participants joined',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Public Event: ${widget.event.isPublic ? 'Yes' : 'No'}',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              )
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
                              embeddedImage: const AssetImage('assets/qr_code_logo/logo.png'), // Embedded image in QR code
                              embeddedImageStyle: const QrEmbeddedImageStyle(
                                size: Size(30, 30),  // Adjust size of the embedded image
                              ),
                              errorCorrectionLevel: QrErrorCorrectLevel.H, // Set high error correction
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
                  : Column(
                      children: [
                        // Show message if user is already registered or joined the event
                        if (currentUser != null && widget.registerMode == true && (registerSuccess || widget.event.participantsRegistered.contains(currentUser.uid)))
                          Text(
                            "You are already marked as registered for this event.",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                        if (currentUser != null && widget.registerMode == false && (joinSuccess || widget.event.participantsJoined.contains(currentUser.uid)))
                          Text(
                            "You have already joined this event.",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                        const SizedBox(height: 8),
                        // Show button to register or join the event
                        MoonButtonWidget(
                          text: widget.registerMode == true ? "Register" : "Join",
                          isDisabled: widget.registerMode == true
                            ? (registerSuccess || (currentUser != null && widget.event.participantsRegistered.contains(currentUser.uid)))
                            : (joinSuccess || (currentUser != null && widget.event.participantsJoined.contains(currentUser.uid))),
                          onPressed: () async {
                            if (currentUser == null) {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => MoonAlertWidget(
                                    icon: Icons.error_outline,
                                    title: "Error",
                                    description: "Please login to ${widget.registerMode == true ? 'register for' : 'join'} the event.",
                                    cancelText: 'Go to login',
                                    typeError: true,
                                  ),
                                ).then((_) {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => const MoonLoginWidget(isFromEventDetails: true,),
                                  );
                                });
                                return;
                            }

                            EventService eventService = EventService();
                            final responseResult = widget.registerMode == true
                                ? await eventService.registerEvent(widget.event.eventUuid)
                                : await eventService.joinEvent(widget.event.eventUuid);

                            if (responseResult.isSuccess) {
                              setState(() {
                                if (widget.registerMode == true) {
                                  registerSuccess = true;
                                } else {
                                  joinSuccess = true;
                                }
                              });
                              showDialog(
                                context: context,
                                builder: (ctx) => MoonAlertWidget(
                                  icon: Icons.check_circle_outline,
                                  title: 'Success',
                                  description: responseResult.message,
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (ctx) => MoonAlertWidget(
                                  icon: Icons.error_outline,
                                  title: "Error",
                                  description: responseResult.message,
                                  typeError: true,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),

            ],
          ),
        ),
      ),
    );
  }
}
