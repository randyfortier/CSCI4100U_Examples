import 'dart:ui';

import 'package:flutter/painting.dart';

import 'package:flame/sprite.dart';

class ImageButton {
  Size screenSize;
  String image;
  String text;
  double textSize = 20;
  double xPadding = 0;
  double yPadding = 0;
  double xOffset = 0;
  double yOffset = 0;
  double xTextOffset = 0;
  double yTextOffset = 0;
  double xPosRatio = 0.5;
  double yPosRatio = 0.5;
  Function onClick;
  Color colour;
  Color shadowColour;

  Rect rect;
  Sprite sprite;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  ImageButton({
    this.screenSize, this.image,
    this.text, this.textSize,
    this.colour, this.shadowColour,
    this.xPadding, this.yPadding,
    this.xOffset, this.yOffset,
    this.xTextOffset, this.yTextOffset,
    this.xPosRatio, this.yPosRatio,
    this.onClick,
  }) {
    sprite = Sprite(image);

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
      (screenSize.width * xPosRatio) - (painter.width / 2) + xTextOffset,
      (screenSize.height * yPosRatio) - (painter.height / 2) + yTextOffset,
    );

    double rectWidth = painter.width + xPadding * 2;
    double rectHeight = painter.height + yPadding * 2;
    rect = Rect.fromLTWH(
      (screenSize.width * xPosRatio) - (rectWidth / 2) + xOffset, 
      (screenSize.height * yPosRatio) - (rectHeight / 2) + yOffset, 
      rectWidth, 
      rectHeight
    );
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    painter.paint(c, position);
  }

  void update(double dt) {}

  void onTapDown() {
    this.onClick();
  }
}