import 'dart:math';

import 'package:at_word_cloud/utils/shape/shape.dart';
import 'package:flutter/material.dart';

class SquareShape extends Shape {
  @override
  void prepare(
    List<MapEntry<String, int>> wordEntries,
    double width,
    double height,
    List<TextPainter> textPainters,
    List<List<double>> wordPoints,
    List<bool> isDrawed,
    Random random,
  ) {
    for (var i = 0; i < wordEntries.length; i++) {
      final textPainter = textPainters[i];
      double x, y;
      while (true) {
        x = random.nextDouble() * (width - textPainter.width);
        y = random.nextDouble() * (height - textPainter.height);

        if (!_isOverlapping(x, y, textPainter, wordPoints, textPainters) &&
            _isWithinBounds(x, y, textPainter, width, height)) {
          break;
        }
      }

      wordPoints.add([x, y]);
      isDrawed.add(true);
    }
  }

  bool _isOverlapping(double x, double y, TextPainter textPainter,
      List<List<double>> wordPoints, List<TextPainter> textPainters) {
    for (var i = 0; i < wordPoints.length; i++) {
      final point = wordPoints[i];
      final tp = textPainters[i];

      if (x < point[0] + tp.width &&
          x + textPainter.width > point[0] &&
          y < point[1] + tp.height &&
          y + textPainter.height > point[1]) {
        return true;
      }
    }
    return false;
  }

  bool _isWithinBounds(double x, double y, TextPainter textPainter,
      double width, double height) {
    return x >= 0 &&
        x + textPainter.width <= width &&
        y >= 0 &&
        y + textPainter.height <= height;
  }
}
