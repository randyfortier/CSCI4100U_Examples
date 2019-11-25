import 'dart:math';
import 'dart:ui';

import 'coin.dart';
import 'player.dart';
import 'tile.dart';
import 'obstacle.dart';

class Level {
  Random random;
  Size screenSize;
  double tileSize;
  List<Tile> floorTiles;
  List<Tile> obstacleTiles;
  List<Coin> coins;
  double numTilesLength;

  Level({this.screenSize, this.tileSize}) {
    initialize();
  }

  void initialize() {
    random = Random(DateTime.now().millisecondsSinceEpoch);

    floorTiles = [];
    obstacleTiles = [];
    coins = [];

    // generate the floor tiles
    numTilesLength = 100;
    for (double xPos = 0; xPos < numTilesLength; xPos += 1) {
      floorTiles.add(Tile(
        screenSize: screenSize,
        tileSize: tileSize,
        image: 'objects/stone_block.png',
        xOffset: xPos,
        yOffset: 0,
      ));
    }

    // generate the obstacles
    createObstacle(Tile.MAX_X_OFFSET);
    createObstacle(Tile.MAX_X_OFFSET + 10);
  }

  void createObstacle(double xOffset) {
    double rand = random.nextDouble();

    if (rand < 0.5) {
      createJump(xOffset);
    } else {
      createSlide(xOffset);
    }
  }

  void createJump(double xOffset) {
    for (double yOffset = 1; yOffset <= 2; yOffset += 1) {
      obstacleTiles.add(Obstacle(
        screenSize: screenSize,
        tileSize: tileSize,
        image: 'objects/crate.png',
        xOffset: xOffset,
        yOffset: yOffset,
      ));
    }

    // Add a coin
    coins.add(Coin(
      screenSize: screenSize,
      tileSize: tileSize,
      xOffset: xOffset,
      yOffset: 4,
    ));
  }


  void createSlide(double xOffset) {
    obstacleTiles.add(Obstacle(
      screenSize: screenSize,
      tileSize: tileSize,
      image: 'objects/crate.png',
      xOffset: xOffset,
      yOffset: 2.6,
    ));

    // Add a coin
    coins.add(Coin(
      screenSize: screenSize,
      tileSize: tileSize,
      xOffset: xOffset,
      yOffset: 1,
    ));
  }

  void render(Canvas canvas) {
    for (Tile tile in floorTiles) {
      tile.render(canvas);
    }

    for (Tile tile in obstacleTiles) {
      tile.render(canvas);
    }

    // draw the coins
    for (Coin coin in coins) {
      coin.render(canvas);
    }
  }

  void update(double dt) {
    for (Tile tile in floorTiles) {
      tile.update(dt);
    }

    bool obstacleDeleted = false;
    for (int i = obstacleTiles.length - 1; i >= 0; i--) {
      if (obstacleTiles[i].update(dt)) {
        obstacleTiles.removeAt(i);
        obstacleDeleted = true;
      }
    }

    if (obstacleDeleted) {
      createObstacle(Tile.MAX_X_OFFSET + 2);
    }

    // Update the coins
    for (Coin coin in coins) {
      coin.update(dt);
    }
  }

  // Check for collision with the player
  int checkPlayerCollisions(Player player) {
    int scoreIncrease = 0;

    // check for obstacle collisions
    for (Tile tile in obstacleTiles) {
      if (player.collidesWith(tile.rect)) {
        player.die();
      }
    }

    // check for coin collisions
    for (Coin coin in coins) {
      if (!coin.isCollected && player.collidesWith(coin.rect)) {
        scoreIncrease += coin.value;
        coin.collect();
      }
    }

    return scoreIncrease;
  }
}