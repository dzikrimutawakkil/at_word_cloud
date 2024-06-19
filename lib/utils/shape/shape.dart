import 'dart:math';
import 'package:at_word_cloud/utils/shape/word_cloud_circle.dart';
import 'package:at_word_cloud/utils/shape/word_cloud_square.dart';
import 'package:flutter/material.dart';

abstract class Shape {
  void prepare(
    List<MapEntry<String, int>> wordEntries,
    double width,
    double height,
    List<TextPainter> textPainters,
    List<List<double>> wordPoints,
    List<bool> isDrawed,
    Random random,
  );

  static final Shape circle = CircleShape();
  static final Shape square = SquareShape();
}
