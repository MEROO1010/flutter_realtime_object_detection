import 'package:flutter/material.dart';
import '../models/recognition.dart';

class BoundingBox extends StatelessWidget {
  final Recognition recognition;

  const BoundingBox({super.key, required this.recognition});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: recognition.x * MediaQuery.of(context).size.width,
      top: recognition.y * MediaQuery.of(context).size.height,
      width: recognition.w * MediaQuery.of(context).size.width,
      height: recognition.h * MediaQuery.of(context).size.height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
        ),
        child: Text(
          '${recognition.label} ${(recognition.confidence * 100).toStringAsFixed(0)}%',
          style: const TextStyle(
            backgroundColor: Colors.red,
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
