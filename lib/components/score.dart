import 'dart:async';
import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../blocs/game/game_cubit.dart';
import '../game/theme_global.dart';

List<Color> colors = [
  Colors.orangeAccent,
  Colors.deepPurple,
  Colors.cyan,
  Colors.yellow,
  Colors.pink,
  Colors.lightGreen,
  Colors.amber,
  Colors.lime,
  Colors.teal,
];

class Score extends TextComponent with HasGameRef {
  final GameCubit cubit;
  late final StreamSubscription _sub;

  Score({
    required this.cubit,
    int initialScore = 0,
  }) : super(
          text: '$initialScore',
          anchor: Anchor.topCenter,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 88,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(gameRef.size.x / 2, 80);

    // Listen for cubit state changes
    _sub = cubit.stream.listen((state) {
      if (state is GamePlaying) {
        setScore(state.points);
      } else if (state is GameOver) {
        setScore(state.points);

        textRenderer = TextPaint(
          style: size88weight700.copyWith(
            color: Colors.greenAccent,
          ),
        );

        log("GameOver -> score=${state.points}, currentBest=${state.currentBest}, highScore=${state.highScore}");
      }
    });
  }

  void setScore(int newScore) {
    text = '$newScore';
    _updateColor(newScore);
  }

  void _updateColor(int score) {
    Color color;
    if (score < 10) {
      color = Colors.white;
    } else {
      final randomIndex = score % colors.length;
      color = colors[randomIndex];
    }

    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 88,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  /// 👇 Reset score text & color
  void reset() {
    text = '0';
    textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 88,
        fontWeight: FontWeight.bold,
        color: Colors.white, // reset back to default
      ),
    );
  }

  @override
  void onRemove() {
    _sub.cancel();
    super.onRemove();
  }
}
