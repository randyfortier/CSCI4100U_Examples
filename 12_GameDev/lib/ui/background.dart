import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:gamedev/treasure_dash_game.dart';

class Background {
  Sprite bgSprite;
  Rect bgRect;

  Background(TreasureDashGame game) {
    bgSprite = Sprite('background.png');

    bgRect = Rect.fromLTWH(
      0, 0, 
      game.tileSize * 16, game.tileSize * 9
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double dt) {}
}