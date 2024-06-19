import 'package:at_word_cloud/utils/shape/shape.dart';
import 'package:at_word_cloud/utils/word_cloud_paint.dart';
import 'package:at_word_cloud/utils/word_cloud_setting.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ATWordCloud extends StatelessWidget {
  final Map<String, int> words;
  double? width;
  double? height;
  double? minTextSize;
  double? maxTextSize;
  Color? backgroundColor;
  List<Color>? textColor;
  Shape? shape;

  ATWordCloud({
    super.key,
    required this.words,
    this.width,
    this.height,
    this.minTextSize,
    this.maxTextSize,
    this.backgroundColor,
    this.textColor,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    final wordCloudSetting = WordCloudSetting(
        words: words,
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height,
        minTextSize: minTextSize ?? 8,
        maxTextSize: maxTextSize ?? 48,
        textColorize: textColor ??
            [
              Colors.black,
              Colors.black87,
              Colors.black54,
              Colors.black45,
              Colors.black38,
              Colors.black26
            ],
        shape: shape ?? Shape.circle);
    wordCloudSetting.prepare();

    return CustomPaint(
      size: Size(width ?? double.infinity, height ?? double.infinity),
      painter: WCpaint(
        wordcloudpaint: wordCloudSetting,
        backgroundColor: backgroundColor ?? Colors.white,
      ),
    );
  }
}
