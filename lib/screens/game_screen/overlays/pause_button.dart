import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/screens/game/guess_the_toilet.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_menu.dart';

class PauseButton extends StatelessWidget {
  static const String id = 'PauseButton';

  const PauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Get access to the game instance
    final game = context
        .findAncestorWidgetOfExactType<GameWidget<GuessTheToilet>>()
        ?.game;

    return Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
        onTap: () {
          // Toggle pause menu when button is pressed
          if (game != null) {
            if (game.overlays.isActive(PauseMenu.id)) {
              game.overlays.remove(PauseMenu.id);
              game.resumeEngine();
            } else {
              game.pauseEngine();
              game.overlays.add(PauseMenu.id);
            }
          }
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  '/assets/images/Main Characters/Bob/idle_down.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
