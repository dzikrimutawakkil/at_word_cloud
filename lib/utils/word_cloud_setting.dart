import 'dart:math';

import 'package:at_word_cloud/utils/shape/shape.dart';
import 'package:flutter/material.dart';

class WordCloudSetting {
  final Map<String, int> words;
  final double width;
  final double height;
  final double minTextSize;
  final double maxTextSize;
  final List<Color> textColorize;
  final Shape shape;
  final List<TextPainter> _textPainters = [];
  final List<List<double>> _wordPoints = [];
  final List<bool> _isDrawed = [];
  final Random _random = Random();

  WordCloudSetting({
    required this.words,
    required this.width,
    required this.height,
    required this.minTextSize,
    required this.maxTextSize,
    required this.textColorize,
    required this.shape,
  });

  void prepare() {
    final wordEntries = words.entries.toList();
    wordEntries.sort((a, b) => b.value.compareTo(a.value));

    for (var entry in wordEntries) {
      final word = entry.key;
      final frequency = entry.value;
      double textSize = _calculateTextSize(wordEntries, frequency);
      final textPainter = _createTextPainter(word, textSize);

      _textPainters.add(textPainter);
    }

    shape.prepare(wordEntries, width, height, _textPainters, _wordPoints,
        _isDrawed, _random);
  }

  double _calculateTextSize(
      List<MapEntry<String, int>> wordEntries, int frequency) {
    double textSize = minTextSize;
    if (wordEntries.length > 1) {
      double minValue = wordEntries[wordEntries.length - 1].value.toDouble();
      double maxValue = wordEntries[0].value.toDouble();

      if (minValue == maxValue) {
        textSize = maxTextSize - wordEntries.length;
      } else {
        textSize = (minTextSize * (maxValue - frequency) +
                maxTextSize * (frequency - minValue)) /
            (maxValue - minValue);
      }
    } else if (wordEntries.length == 1) {
      textSize = maxTextSize;
    }
    return textSize;
  }

  TextPainter _createTextPainter(String word, double textSize) {
    return TextPainter(
      text: TextSpan(
        text: word,
        style: TextStyle(
            height: 1,
            fontSize: textSize,
            color: textColorize[_random.nextInt(textColorize.length)],
            fontWeight: FontWeight.normal),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  List<TextPainter> getTextPainter() => _textPainters;
  List<List<double>> getWordPoint() => _wordPoints;
  List<bool> get isDrawed => _isDrawed;
  int getDataLength() => _textPainters.length;
}
