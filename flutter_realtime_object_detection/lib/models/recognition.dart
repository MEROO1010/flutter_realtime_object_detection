class Recognition {
  final String label;
  final double confidence;
  final double x;
  final double y;
  final double w;
  final double h;

  Recognition(this.label, this.confidence, this.x, this.y, this.w, this.h);

  static List<Recognition> fromTFLiteResults(List? results) {
    if (results == null) return [];
    return results
        .map(
          (e) => Recognition(
            e['detectedClass'],
            e['confidenceInClass'],
            e['rect']['x'],
            e['rect']['y'],
            e['rect']['w'],
            e['rect']['h'],
          ),
        )
        .toList();
  }
}
