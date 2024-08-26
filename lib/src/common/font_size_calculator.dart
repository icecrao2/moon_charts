

import 'package:flutter/cupertino.dart';



double calculateFontSizeWithHeight(String text, double targetHeight, BuildContext context) {
  double fontSize = 1.0;
  TextPainter painter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  while (true) {
    painter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: fontSize),
    );
    painter.layout();
    if (painter.height >= targetHeight) {
      break;
    }
    fontSize += 0.5;
  }

  return fontSize;
}

double calculateFontSizeWithWidth(String text, double targetWidth, BuildContext context) {
  double fontSize = 1.0;
  TextPainter painter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  while (true) {
    painter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: fontSize),
    );
    painter.layout();
    if (painter.width >= targetWidth) {
      break;
    }
    fontSize += 0.5;
  }

  return fontSize - 0.5;
}