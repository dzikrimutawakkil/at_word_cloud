import 'dart:math';

import 'package:at_word_cloud/utils/shape/shape.dart';
import 'package:flutter/material.dart';

class CircleShape extends Shape {
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
    final centerX = width / 2;
    final centerY = height / 2;

    for (var i = 0; i < wordEntries.length; i++) {
      final textPainter = textPainters[i];
      double x, y;
      if (i == 0) {
        x = centerX - textPainter.width / 2;
        y = centerY - textPainter.height / 2;
      } else {
        double angle = 0;
        double radius = 0;

        while (true) {
          x = centerX + radius * cos(angle) - textPainter.width / 2;
          y = centerY + radius * sin(angle) - textPainter.height / 2;

          if (!_isOverlapping(x, y, textPainter, wordPoints, textPainters) &&
              _isWithinBounds(x, y, textPainter, width, height)) {
            break;
          }

          angle += 0.1;
          radius += 0.1;
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
