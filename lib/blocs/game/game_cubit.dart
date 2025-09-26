import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial()) {
    _loadHighScore();
  }

  int _currentBest = 0; // Best since app launch
  int _highScore = 0; // Stored permanently

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highScore = prefs.getInt('highScore') ?? 0;
    print('====highScore====> $_highScore');
  }

  Future<void> _saveHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highScore', score);
  }

  void startGame() => emit(const GamePlaying(0));

  void addPoint() {
    if (state is GamePlaying) {
      final current = (state as GamePlaying).points;
      emit(GamePlaying(current + 1));
      log("Points: ${current + 1}");
    }
  }

  void gameOver() {
    if (state is GamePlaying) {
      final points = (state as GamePlaying).points;

      // update currentBest
      if (points > _currentBest) {
        _currentBest = points;
      }

      // update highScore
      if (points > _highScore) {
        _highScore = points;
        _saveHighScore(_highScore);
      }

      emit(GameOver(
        points: points,
        currentBest: _currentBest,
        highScore: _highScore,
      ));

      log('Final Points: $points');
      log('Current Best: $_currentBest');
      log('High Score: $_highScore');
    }
  }

  void resetGame() => emit(GameInitial());
}
