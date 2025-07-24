import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../constants/colors.dart';

class TextLimiterOvertime extends StatelessWidget {
  final String text;

  const TextLimiterOvertime({super.key, required this.text});

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
    TextStyle textStyle = blackTextStyle.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    bool overflow = isTextOverflow(text, textStyle,
        MediaQueryData.fromView(View.of(context)).size.width - 200);

    return SizedBox(
      height: 30, // Sesuaikan tinggi sesuai kebutuhan
      width: MediaQueryData.fromView(View.of(context)).size.width - 200,
      child: overflow
          ? Marquee(
              style: textStyle,
              text: "Overtime for $text",
              scrollAxis: Axis.horizontal,
              blankSpace: 20.0,
              velocity: 30.0,
              pauseAfterRound: Duration(seconds: 1),
              startPadding: 10.0,
            )
          : Text(
              "Overtime for $text",
              style: textStyle,
            ),
    );
  }
}
