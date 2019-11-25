import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'gfx/level.dart';
import 'gfx/player.dart';
import 'ui/screen.dart';
import 'ui/background.dart';
import 'ui/image_button.dart';
import 'ui/image_toggle_button.dart';
import 'ui/text.dart';

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
  Level level;
  Player player;
  ImageButton jumpButton;
  ImageButton slideButton;

  int score;
  int highScore = 0;
  bool gameOver = false;

  Text currentScoreText;
  Text highScoreText;

  Text gameOverText;

  final SharedPreferences storage;

  TreasureDashGame(this.storage) {
    initialize();
  }

  Future<void> initialize() async {
    // start a new game
    score = 0;

    // load high score
    highScore = storage.containsKey('highScore') ? storage.get('highScore') : 0;

    frameDelay = 1.0 / fps;

    resize(await Flame.util.initialDimensions());

    tileSize = 50;
    level = Level(screenSize: screenSize, tileSize: tileSize);

    background = Background(this);

    // buttons for the main menu

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

    // elements for the gameplay screen

    player = Player(
      screenSize: screenSize,
      frameDelay: frameDelay * 2,
      jumpSpeed: 11.0,
      gameOverCallback: () {
        gameOver = true;
        currentScreen = Screen.playagain;
      }
    );

    jumpButton = ImageButton(
      screenSize: screenSize,
      image: 'controls/arrow-up.png',
      text: ' ',
      textSize: 30,
      xPadding: 40,
      yPadding: 25,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.9,
      yPosRatio: 0.3,
      onClick: () {
        player.jump();
      }
    );

    slideButton = ImageButton(
      screenSize: screenSize,
      image: 'controls/arrow-down.png',
      text: ' ',
      textSize: 30,
      xPadding: 40,
      yPadding: 25,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.9,
      yPosRatio: 0.7,
      onClick: () {
        player.slide();
      }
    );

    currentScoreText = Text(
      screenSize: screenSize,
      text: 'Score: $score',
      textSize: 30,
      xOffset: 0,
      yOffset: 0,
      xPosRatio: 0.2,
      yPosRatio: 0.1,
    );

    highScoreText = Text(
      screenSize: screenSize,
      text: 'High Score: $highScore',
      textSize: 30,
      xOffset: 0,
      yOffset: 0,
      xPosRatio: 0.8,
      yPosRatio: 0.1,
    );

    // play again screen elements

    gameOverText = Text(
      screenSize: screenSize,
      text: 'Game Over',
      textSize: 70,
      xOffset: 0,
      yOffset: 0,
      xPosRatio: 0.5,
      yPosRatio: 0.4,
    );

    playAgainButton = ImageButton(
      screenSize: screenSize,
      image: 'button_background.png',
      text: 'Play Again',
      textSize: 50,
      xPadding: 60,
      yPadding: 35,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.5,
      yPosRatio: 0.7,
      onClick: () {
        goToGameState(Screen.gameplay);
        level.initialize();
        player.reset();
        score = 0;
        gameOver = false;
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
    } else if (currentScreen == Screen.gameplay) {
      level?.render(canvas);
      player?.render(canvas);
      jumpButton?.render(canvas);
      slideButton?.render(canvas);
      currentScoreText?.render(canvas);
      highScoreText?.render(canvas);
    } else if (currentScreen == Screen.playagain) {
      gameOverText?.render(canvas);
      playAgainButton?.render(canvas);
    }
  }

  void update(double dt) {
    // Gameplay updates
    if (!gameOver && currentScreen == Screen.gameplay) {
      level?.update(dt);
      player?.update(dt);

      // handle collisions with obstacles and coins
      int scoreIncrease = level?.checkPlayerCollisions(player);
      addToScore(scoreIncrease);
    }
  }

  void addToScore(int amount) {
    score += amount;
    currentScoreText.setText('Score: $score');

    // check if we have a new high score
    if (score > highScore) {
      highScore = score;
      highScoreText.setText('High Score: $highScore');

      // save the new high score
      storage.setInt('highScore', highScore);
    }
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

    isHandled = passTapIfNecessary(Screen.gameplay, jumpButton, event);
    isHandled = passTapIfNecessary(Screen.gameplay, slideButton, event);

    isHandled = passTapIfNecessary(Screen.playagain, playAgainButton, event);
  }
}