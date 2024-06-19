import 'package:at_word_cloud/utils/word_cloud_setting.dart';
import 'package:flutter/material.dart';

class WCpaint extends CustomPainter {
  final WordCloudSetting wordcloudpaint;
  final Color backgroundColor;

  WCpaint({
    required this.wordcloudpaint,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    for (var i = 0; i < wordcloudpaint.getDataLength(); i++) {
      if (wordcloudpaint.isDrawed[i]) {
        wordcloudpaint.getTextPainter()[i].paint(
              canvas,
              Offset(wordcloudpaint.getWordPoint()[i][0],
                  wordcloudpaint.getWordPoint()[i][1]),
            );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
