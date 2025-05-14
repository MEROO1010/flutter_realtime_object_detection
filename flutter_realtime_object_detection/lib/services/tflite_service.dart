import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import '../models/recognition.dart';

class TFLiteService {
  static Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/models/detect.tflite',
      labels: 'assets/models/labelmap.txt',
    );
  }

  static Future<List<Recognition>> runModelOnFrame(CameraImage image) async {
    var recognitions = await Tflite.detectObjectOnFrame(
      bytesList: image.planes.map((plane) => plane.bytes).toList(),
      imageHeight: image.height,
      imageWidth: image.width,
      numResultsPerClass: 1,
      threshold: 0.4,
    );
    return Recognition.fromTFLiteResults(recognitions);
  }

  static void disposeModel() {
    Tflite.close();
  }
}
