import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/game/game_cubit.dart';
import 'game/football_tap_game.dart';

/// This example simply adds a rotating white square on the screen.
/// If you press on a square, it will be removed.
/// If you press anywhere else, another square will be added.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider(
      create: (_) => GameCubit(),
      child: GameWidget(
        game: FootballTapGame(
          cubit: GameCubit(),
        ),
      ),
    ),
  );
}

// class MyWorld extends World with TapCallbacks {
//   @override
//   Future<void> onLoad() async {
//     add(Square(Vector2.zero()));
//   }
//
//   @override
//   void onTapDown(TapDownEvent event) {
//     super.onTapDown(event);
//     if (!event.handled) {
//       final touchPoint = event.localPosition;
//       add(Square(touchPoint));
//     }
//   }
// }
//
// class Square extends RectangleComponent with TapCallbacks {
//   static const speed = 3;
//   static const squareSize = 128.0;
//   static const indicatorSize = 6.0;
//
//   static final Paint red = BasicPalette.red.paint();
//   static final Paint blue = BasicPalette.purple.paint();
//
//   Square(Vector2 position)
//       : super(
//           position: position,
//           size: Vector2.all(squareSize),
//           anchor: Anchor.center,
//         );
//
//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//     add(
//       RectangleComponent(
//         size: Vector2.all(indicatorSize),
//         paint: blue,
//       ),
//     );
//     add(
//       RectangleComponent(
//         position: size / 2,
//         size: Vector2.all(indicatorSize),
//         anchor: Anchor.center,
//         paint: red,
//       ),
//     );
//   }
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//     angle += speed * dt;
//     angle %= 2 * math.pi;
//   }
//
//   @override
//   void onTapDown(TapDownEvent event) {
//     removeFromParent();
//     event.handled = true;
//   }
// }
