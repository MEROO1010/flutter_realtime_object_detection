import 'package:flutter/material.dart';
import 'screens/detection_screen.dart';

void main() {
  runApp(const ObjectDetectionApp());
}

class ObjectDetectionApp extends StatelessWidget {
  const ObjectDetectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real-Time Object Detection',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const DetectionScreen(),
    );
  }
}
