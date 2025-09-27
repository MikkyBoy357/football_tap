import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../blocs/game/game_cubit.dart';

class CurrentBest extends TextComponent with HasGameReference {
  final GameCubit cubit;
  final bool shouldDisplay;

  CurrentBest({required this.shouldDisplay, required this.cubit})
    : super(
        text: 'Current Best',
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.lightGreen,
          ),
        ),
      );

  void toggleDisplay(bool value) {
    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: value ? Colors.white : Colors.transparent,
        // outline
        shadows: [
          Shadow(
            offset: Offset(2.0, -2.0),
            blurRadius: 2.0,
            color: Colors.cyan[900]!,
          ),
          Shadow(
            offset: Offset(-2.0, 2.0),
            blurRadius: 2.0,
            color: Colors.deepPurple[900]!,
          ),
        ],
      ),
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(game.size.x / 2, 65);

    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: shouldDisplay ? Colors.white : Colors.transparent,
        // outline
        shadows: [
          Shadow(
            offset: Offset(2.0, -2.0),
            blurRadius: 2.0,
            color: Colors.cyan[900]!,
          ),
          Shadow(
            offset: Offset(-2.0, 2.0),
            blurRadius: 2.0,
            color: Colors.deepPurple[900]!,
          ),
        ],
      ),
    );
  }
}
