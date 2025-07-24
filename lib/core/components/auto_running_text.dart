import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AutoRunningText extends StatelessWidget {
  final String text;
  final double maxWidth;

  const AutoRunningText(
      {super.key, required this.text, required this.maxWidth});

  bool isTextOverflow(String text, TextStyle style, double maxWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.normal,
    );

    bool overflow = isTextOverflow(text, textStyle, maxWidth);

    return SizedBox(
      height: 30, // Sesuaikan tinggi sesuai kebutuhan
      width: maxWidth,
      child: overflow
          ? Marquee(
              text: text,
              style: textStyle,
              scrollAxis: Axis.horizontal,
              blankSpace: 20.0,
              velocity: 30.0,
              pauseAfterRound: Duration(seconds: 1),
              startPadding: 10.0,
            )
          : Text(
              text,
              style: textStyle,
              overflow: TextOverflow.ellipsis, // Potong jika terlalu panjang
            ),
    );
  }
}
