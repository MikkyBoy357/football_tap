import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:football_tap/game/assets.dart';
import 'package:football_tap/game/football_tap_game.dart';

class Background extends SpriteComponent with HasGameRef<FootballTapGame> {
  Background();

  @override
  FutureOr<void> onLoad() async {
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
