// ignore_for_file: unnecessary_this, prefer_const_constructors, prefer_final_fields, unused_import, unnecessary_null_comparison

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laporbos/handler/attendanceQrHandler.dart';
import 'package:laporbos/service/attendanceQrService.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class UtilScanner extends StatefulWidget {
  const UtilScanner({super.key});

  @override
  State<UtilScanner> createState() => _ScannerState();
}

class _ScannerState extends State<UtilScanner> {
  bool _flashOn = false;
  bool _frontCam = false;
  GlobalKey _qrKey = GlobalKey();
  late QRViewController _controller;
  final TextEditingController cust_id = TextEditingController();
  final TextEditingController locQR = TextEditingController();

  void attendanceQrHandler() {
    AttendanceQrHandler(context).atttendanceQr(
      cust_id.text,
      locQR.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {},
            );
          },
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
          "Scan QR Code",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: _qrKey,
            overlay: QrScannerOverlayShape(borderColor: Colors.white),
            onQRViewCreated: (QRViewController controller) {
              this._controller = controller;
              controller.scannedDataStream.listen((barcode) {
                if (mounted) {
                  _controller.dispose();
                  Navigator.pop(context, barcode);
                  // Perform validation on the scanned QR code content
                  attendanceQrHandler(); // Invoke the method here
                }
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
                  onPressed: () {
                    setState(() {
                      _flashOn = !_flashOn;
                    });
                    _controller.toggleFlash();
                  },
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      _frontCam = !_frontCam;
                    });
                    _controller.flipCamera();
                  },
                  icon: Icon(
                    _frontCam ? Icons.camera_front : Icons.camera_rear,
                  ),
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
