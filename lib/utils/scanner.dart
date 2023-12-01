// ignore_for_file: unnecessary_this, prefer_const_constructors, prefer_final_fields, unused_import, unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laporbos/handler/attendanceQrHandler.dart';
import 'package:laporbos/model/attendanceqr.dart';
import 'package:laporbos/service/attendanceQrService.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class ScannerUtils extends StatefulWidget {
  final String authToken;

  ScannerUtils({Key? key, required this.authToken}) : super(key: key);

  @override
  State<ScannerUtils> createState() => _ScannerState(authToken: authToken);
}

class _ScannerState extends State<ScannerUtils> {
  bool _flashOn = false;
  bool _frontCam = false;
  bool isValidationInProgress = false;
  GlobalKey _qrKey = GlobalKey();
  late QRViewController _controller;
  late QRCodeHandler _qrCodeHandler;
  final String authToken;

  _ScannerState({required this.authToken});
  @override
  void initState() {
    super.initState();
    _qrCodeHandler = QRCodeHandler(custId: widget.authToken);
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
              controller.scannedDataStream.listen((barcode) async {
                if (isValidationInProgress) {
                  return;
                }

                isValidationInProgress = true;

                bool validationSuccess =
                    await _qrCodeHandler.handleQRCode(barcode.code!, authToken);

                if (validationSuccess) {
                  Navigator.pop(context, barcode);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Qr Code Tidak sesuai / gagal membaca !'),
                    ),
                  );

                  // Navigator.pop(context);

                  Future.delayed(Duration(seconds: 1), () {
                    isValidationInProgress = false;

                    if (_controller != null && _controller.hasPermissions) {
                      _controller.resumeCamera();
                    }
                  });
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
