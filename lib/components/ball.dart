import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:football_tap/game/football_tap_game.dart';

import '../game/assets.dart';

typedef BallTapCallback = void Function();
typedef BallOutOfBoundsCallback = void Function();

class Ball extends SpriteComponent
    with HasGameReference<FootballTapGame>, TapCallbacks {
  double velocityY = 0.0;
  final double gravity = 1400;
  final double jumpStrength = -800;

  bool gravityEnabled = false;

  BallTapCallback? onTapped;
  BallOutOfBoundsCallback? onOutOfBounds;

  late Vector2 initialPosition;

  @override
  FutureOr<void> onLoad() async {
    final ball = await game.loadSprite(Assets.ball);

    size = Vector2(120, 125);
    initialPosition = Vector2(game.size.x / 2, game.size.y - (size.y * 2));

    position = initialPosition.clone();
    sprite = ball;
    anchor = Anchor.center;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!gravityEnabled) {
      gravityEnabled = true; // first tap starts gravity
    }

    // bounce up
    velocityY = jumpStrength;

    // notify game
    onTapped?.call();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!gravityEnabled) return;

    velocityY += gravity * dt;
    position.y += velocityY * dt;

    if (position.y - size.y / 2 > game.size.y) {
      // out of bounds
      onOutOfBounds?.call();
    }
  }

  /// Reset ball after game over
  void reset() {
    gravityEnabled = false;
    velocityY = 0.0;
    position = initialPosition.clone();
  }
}
