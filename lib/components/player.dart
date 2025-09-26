import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Player extends CircleComponent with TapCallbacks, HasGameRef {
  double velocityY = 0.0;
  final double gravity = 600; // pixels per second^2
  final double jumpStrength = -400; // negative = up

  Player({
    required super.position,
    required double radius,
    Color color = Colors.deepPurpleAccent,
  }) : super(
          anchor: Anchor.center,
          radius: radius,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill,
        );

  @override
  void onTapDown(TapDownEvent event) {
    // give the player an upward impulse
    velocityY = jumpStrength;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // apply gravity
    velocityY += gravity * dt;

    // move player
    position.y += velocityY * dt;

    // stop at "ground" level
    final groundY = gameRef.size.y / 1.25;
    if (position.y > groundY) {
      position.y = groundY;
      velocityY = 0.0;
    }
  }
}
