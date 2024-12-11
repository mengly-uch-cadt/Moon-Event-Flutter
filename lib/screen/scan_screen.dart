// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/services/event_service.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/event/moon_event_details_widget.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class MoonScanScreen extends StatefulWidget {
  const MoonScanScreen({super.key});

  @override
  MoonScanScreenState createState() => MoonScanScreenState();
}

class MoonScanScreenState extends State<MoonScanScreen> {
  EventService eventService = EventService();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool flashOn = false;
  bool frontCamera = false;
  Future<dynamic>? responseResult;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 5,
                    child: MoonButtonWidget(
                    onPressed: () {
                      controller?.toggleFlash();
                      setState(() {
                      flashOn = !flashOn;
                      });
                    },
                    text: 'Flash',
                    icon: Icon(
                      flashOn ? Icons.flash_on : Icons.flash_off,
                    ),
                    textColor: flashOn ? AppColors.star : AppColors.white,
                    ),
                ),
                const SizedBox(width: 10),
                 Expanded(
                  flex: 5,
                  child: MoonButtonWidget(
                    onPressed: () {
                      controller?.flipCamera();
                      setState(() {
                        frontCamera = !frontCamera;
                      });
                    },
                    text: frontCamera? 'Front Camera':"Back Camera",
                    icon: const Icon(
                      Icons.flip_camera_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        String eventId = result!.code!;
        responseResult = eventService.getEventById(eventId);
        responseResult!.then((value) {
          if(value.isSuccess){
            reassemble();
            GetEvent event = value.data!;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MoonEventDetailsWidget(event: event);
              },
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MoonEventDetailsWidget(event: event, registerMode: false,);
              },
            );
          }else{
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MoonAlertWidget(
                  icon: Icons.error_outline,
                  title: 'Error',
                  description: value.message,
                  typeError: true,
                );
              },
            );
          }
        });
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
