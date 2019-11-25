import 'dart:ui';

import 'package:flutter/painting.dart';

class Text {
  Size screenSize;
  String text;
  double textSize;
  double xOffset = 0;
  double yOffset = 0;
  double xPosRatio = 0.5;
  double yPosRatio = 0.5;
  Color colour;
  Color shadowColour;

  Rect rect;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  Text({
    this.screenSize,
    this.text, this.textSize,
    this.colour, this.shadowColour,
    this.xOffset, this.yOffset,
    this.xPosRatio, this.yPosRatio,
  }) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: colour == null ? Color(0xffffffff) : colour,
      fontSize: textSize,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: shadowColour == null ? Color(0xff000000) : shadowColour,
          offset: Offset(3, 3),
        ),
      ],
    );

    position = Offset.zero;

    setText(text);
  }

  void setText(String text) {
    painter.text = TextSpan(
      text: text,
      style: textStyle,
    );

    painter.layout();

    position = Offset(
      (screenSize.width * xPosRatio) - (painter.width / 2) + xOffset,
      (screenSize.height * yPosRatio) - (painter.height / 2) + yOffset,
    );
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double dt) {}

  void onTapDown() {}
}