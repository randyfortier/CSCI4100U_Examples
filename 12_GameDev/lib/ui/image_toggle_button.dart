import 'dart:ui';

import 'package:flame/sprite.dart';

import 'image_button.dart';

class ImageToggleButton extends ImageButton {
  String imageOn;
  String imageOff;

  bool toggleState = true;

  ImageToggleButton({
    Size screenSize, this.toggleState,
    this.imageOn, this.imageOff,
    double xPosRatio, double yPosRatio,
    Function onClick,
  }) : super(
    screenSize: screenSize,
    image: toggleState ? imageOn : imageOff,
    text: ' ',
    textSize: 10,
    xPadding: 20,
    yPadding: 20,
    xOffset: 0,
    yOffset: 0,
    xTextOffset: 0,
    yTextOffset: 0,
    xPosRatio: xPosRatio,
    yPosRatio: yPosRatio,
    onClick: onClick,
  ) {
    onClick(toggleState);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    painter.paint(c, position);
  }

  void onTapDown() {
    toggleState = !toggleState;

    if (toggleState) {
      this.sprite = Sprite(this.imageOn);
    } else {
      this.sprite = Sprite(this.imageOff);
    }

    if (this.onClick != null) {
      this.onClick(toggleState);
    }
  }
}