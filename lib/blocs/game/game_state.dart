part of 'game_cubit.dart';

sealed class GameState extends Equatable {
  const GameState();
}

final class GameInitial extends GameState {
  @override
  List<Object> get props => [];
}

class GamePlaying extends GameState {
  final int points;

  const GamePlaying(this.points);

  @override
  List<Object?> get props => [points];
}

class GameOver extends GameState {
  final int points;
  final int currentBest;
  final int highScore;

  const GameOver({
    required this.points,
    required this.currentBest,
    required this.highScore,
  });

  @override
  List<Object?> get props => [points, currentBest, highScore];
}
