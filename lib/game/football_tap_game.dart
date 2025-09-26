import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:football_tap/components/background.dart';
import 'package:football_tap/components/ball.dart';
import 'package:football_tap/components/player.dart';

import '../blocs/game/game_cubit.dart';
import '../components/score.dart';

class FootballTapGame extends FlameGame {
  final GameCubit cubit;

  FootballTapGame({required this.cubit});

  late Ball ball;
  late Player player;
  late Score score;

  @override
  Color backgroundColor() => Colors.green;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final width = size.x;
    final height = size.y;
    final playerPosition = Vector2(width / 2, height / 1.25);

    score = Score(
      cubit: cubit,
      initialScore: 0,
    );

    player = Player(
      position: playerPosition,
      radius: 50.0,
    );

    ball = Ball()
      ..onTapped = () {
        if (cubit.state is GameInitial) {
          cubit.startGame();
        }
        if (cubit.state is GameOver) {
          cubit.startGame();
        }
        cubit.addPoint();
      }
      ..onOutOfBounds = () {
        cubit.gameOver();
        ball.reset(); // reset position + stop gravity
      };

    addAll([
      Background(),
      score,
      ball,
    ]);
  }
}
