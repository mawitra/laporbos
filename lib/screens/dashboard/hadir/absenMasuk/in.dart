// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class AbsenIn extends StatefulWidget {
  @override
  _AbsenInState createState() => _AbsenInState();
}

class _AbsenInState extends State<AbsenIn> {
  late CameraController _cameraController;
  late List<CameraDescription> cameras;
  late FaceDetector faceDetector;
  late InputImage inputImage;
  bool isCameraInitialized = false;
  late bool _isDetectingFace;
  late XFile _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    faceDetector = GoogleMlKit.vision.faceDetector();
    _isDetectingFace = false;
    _capturedImage = XFile(''); // Initialize with an empty XFile
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      await _cameraController.initialize();
      if (mounted) {
        setState(() {
          isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _toggleCameraDirection() async {
    if (!isCameraInitialized) {
      return;
    }

    final CameraDescription currentCamera = _cameraController.description;
    final CameraDescription newCamera =
        (currentCamera.lensDirection == CameraLensDirection.front)
            ? cameras.firstWhere(
                (camera) => camera.lensDirection == CameraLensDirection.back)
            : cameras.firstWhere(
                (camera) => camera.lensDirection == CameraLensDirection.front);

    if (_cameraController != null) {
      await _cameraController.dispose();
    }

    _cameraController = CameraController(newCamera, ResolutionPreset.medium);
    await _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _detectFace(CameraImage image) async {
    if (!isCameraInitialized || _isDetectingFace) {
      return;
    }

    try {
      _isDetectingFace = true;

      inputImage = InputImage.fromBytes(
        bytes: image.planes[0].bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: InputImageRotation.rotation0deg,
          format: InputImageFormat.yuv420, // Use the appropriate format
          bytesPerRow: image.planes[0].bytesPerRow!,
        ),
      );

      final List<Face> faces = await faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {
        _cameraController.stopImageStream();

        _capturedImage = await _cameraController.takePicture();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.white,
              child: Container(
                color: Colors.white,
                child: Image.file(
                  File(_capturedImage.path),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      print('Error during face detection: $e');
    } finally {
      _isDetectingFace = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) {
      return Scaffold(
        body: Center(),
      );
    }
    final cameraAspectRatio = _cameraController.value.aspectRatio;
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detection Camera'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AspectRatio(
            aspectRatio: cameraAspectRatio,
            child: CameraPreview(_cameraController),
          ),
          ElevatedButton(
            onPressed: () {
              if (_cameraController != null &&
                  _cameraController.value.isStreamingImages) {
                _cameraController.stopImageStream();
              } else {
                _cameraController.startImageStream((CameraImage image) {
                  _detectFace(image);
                });
              }
            },
            child: Text(_cameraController != null &&
                    _cameraController.value.isStreamingImages
                ? 'Stop Face Detection'
                : 'Start Face Detection'),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: _toggleCameraDirection,
              child: Icon(Icons.flip_camera_android),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_cameraController != null) {
      _cameraController.dispose();
    }
    faceDetector.close();
    super.dispose();
  }
}
