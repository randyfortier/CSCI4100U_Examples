import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'ui/screen.dart';
import 'ui/background.dart';
import 'ui/image_button.dart';
import 'ui/image_toggle_button.dart';

class TreasureDashGame extends Game {
  Size screenSize;
  double tileSize;
  double fps = 20;
  double frameDelay;

  Screen currentScreen;
  ImageButton playButton;
  ImageButton quitButton;
  ImageButton creditsButton;
  ImageButton musicButton;
  ImageButton playAgainButton;

  Background background;

  int score;
  
  //Level level;
  //Player player;

  final SharedPreferences storage;

  TreasureDashGame(this.storage) {
    initialize();
  }

  Future<void> initialize() async {
    frameDelay = 1.0 / fps;

    resize(await Flame.util.initialDimensions());

    tileSize = 50;

    background = Background(this);

    playButton = ImageButton(
      screenSize: screenSize,
      image: 'button_background.png',
      text: 'Play',
      textSize: 50,
      xPadding: 60,
      yPadding: 35,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.5,
      yPosRatio: 0.3,
      onClick: () {
        goToGameState(Screen.gameplay);
        score = 0;
        print('play game');
      }
    );

    creditsButton = ImageButton(
      screenSize: screenSize,
      image: 'button_background.png',
      text: 'Credits',
      textSize: 30,
      xPadding: 40,
      yPadding: 25,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.5,
      yPosRatio: 0.6,
      onClick: () {
        // TODO: Show the credits screen
        print('show the credits');
      }
    );

    quitButton = ImageButton(
      screenSize: screenSize,
      image: 'button_background.png',
      text: 'Quit',
      textSize: 30,
      xPadding: 40,
      yPadding: 25,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.5,
      yPosRatio: 0.8,
      onClick: () {
        // quit the game
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    );

    musicButton = ImageToggleButton(
      screenSize: screenSize,
      imageOn: 'controls/music-on.png',
      imageOff: 'controls/music-off.png',
      xPosRatio: 0.05,
      yPosRatio: 0.1,
      toggleState: true,
      onClick: (toggleState) {
        // TODO: Toggle audio
        print('toggle audio');
      }
    );

    currentScreen = Screen.menu;
  }

  void goToGameState(Screen gameState) {
    currentScreen = gameState;

    // TODO: Reset music
  }

  void render(Canvas canvas) {
    background?.render(canvas);
    if (currentScreen == Screen.menu) {
      playButton?.render(canvas);
      creditsButton?.render(canvas);
      quitButton?.render(canvas);
      musicButton?.render(canvas);
    }
  }

  void update(double dt) {
    // TODO: Gameplay updates
  }

  void resize(Size size) {
    screenSize = size;
  }

  bool passTapIfNecessary(
    Screen desiredScreen,
    ImageButton button,
    TapDownDetails event,
  ) {
    if (button.rect.contains(event.globalPosition)) {
      if (currentScreen == desiredScreen) {
        button.onTapDown();
        return true;
      }
    }
  }

  void onTapDown(TapDownDetails event) {
    bool isHandled = false;

    isHandled = passTapIfNecessary(Screen.menu, playButton, event);
    isHandled = passTapIfNecessary(Screen.menu, creditsButton, event);
    isHandled = passTapIfNecessary(Screen.menu, quitButton, event);
    isHandled = passTapIfNecessary(Screen.menu, musicButton, event);
  }
}