import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';

import 'treasure_dash_game.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.landscapeRight);

  Flame.images.loadAll(<String>[
    'background.png',
    'button_background.png',
    'controls/music-on.png',
    'controls/music-off.png',
    'coins/shine/shine1.png',
    'coins/shine/shine2.png',
    'coins/shine/shine3.png',
    'coins/shine/shine4.png',
    'coins/shine/shine5.png',
    'coins/shine/shine6.png',
    'adventuregirl/dead1.png',
    'adventuregirl/dead2.png',
    'adventuregirl/dead3.png',
    'adventuregirl/dead4.png',
    'adventuregirl/dead5.png',
    'adventuregirl/dead6.png',
    'adventuregirl/dead7.png',
    'adventuregirl/dead8.png',
    'adventuregirl/dead9.png',
    'adventuregirl/dead10.png',
    'adventuregirl/jump1.png',
    'adventuregirl/jump2.png',
    'adventuregirl/jump3.png',
    'adventuregirl/jump4.png',
    'adventuregirl/jump5.png',
    'adventuregirl/jump6.png',
    'adventuregirl/jump7.png',
    'adventuregirl/jump8.png',
    'adventuregirl/jump9.png',
    'adventuregirl/jump10.png',
    'adventuregirl/run1.png',
    'adventuregirl/run2.png',
    'adventuregirl/run3.png',
    'adventuregirl/run4.png',
    'adventuregirl/run5.png',
    'adventuregirl/run6.png',
    'adventuregirl/run7.png',
    'adventuregirl/run8.png',
    'adventuregirl/slide1.png',
    'adventuregirl/slide2.png',
    'adventuregirl/slide3.png',
    'adventuregirl/slide4.png',
    'adventuregirl/slide5.png',
  ]);

  Flame.audio.disableLog();
  await Flame.audio.loadAll(<String>[
    'music/menu.mp3',
    'music/gameplay.mp3',
  ]);

  SharedPreferences storage = await SharedPreferences.getInstance();

  TreasureDashGame game = TreasureDashGame(storage);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  runApp(game.widget);
  flameUtil.addGestureRecognizer(tapper);
}