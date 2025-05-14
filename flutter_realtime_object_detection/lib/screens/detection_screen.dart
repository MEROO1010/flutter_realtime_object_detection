import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../services/tflite_service.dart';
import '../widgets/bounding_box.dart';
import '../models/recognition.dart';

class DetectionScreen extends StatefulWidget {
  const DetectionScreen({super.key});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _isDetecting = false;
  List<Recognition> _recognitions = [];

  @override
  void initState() {
    super.initState();
    initCamera();
    TFLiteService.loadModel();
  }

  void initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
    _cameraController.startImageStream((CameraImage image) {
      if (!_isDetecting) {
        _isDetecting = true;
        TFLiteService.runModelOnFrame(image).then((recognitions) {
          setState(() {
            _recognitions = recognitions;
          });
          _isDetecting = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    TFLiteService.disposeModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_cameraController),
          ..._recognitions.map((recog) => BoundingBox(recognition: recog)),
        ],
      ),
    );
  }
}
