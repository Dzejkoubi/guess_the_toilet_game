import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/screens/game/guess_the_toilet.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_menu.dart';

class PauseButton extends StatefulWidget {
  static const String id = 'PauseButton';

  const PauseButton({super.key});

  // Add a static method that can be called from anywhere
  static bool toggleGamePause(GuessTheToilet game) {
    if (game.isPlayerOnRoadmap) {
      print('Player cannot stop game when player is on roadmap');
      return false;
    }

    if (game.overlays.isActive(PauseMenu.id)) {
      // Resume the game
      game.overlays.remove(PauseMenu.id);
      game.resumeEngine();
      return false; // Not paused
    } else {
      // Pause the game
      game.pauseEngine();
      game.overlays.add(PauseMenu.id);
      return true; // Paused
    }
  }

  @override
  State<PauseButton> createState() => _PauseButtonState();
}

class _PauseButtonState extends State<PauseButton> {
  @override
  Widget build(BuildContext context) {
    // Get access to the game instance
    final game = context
        .findAncestorWidgetOfExactType<GameWidget<GuessTheToilet>>()
        ?.game;

    // Check if pause menu is active
    final isPaused = game?.overlays.isActive(PauseMenu.id) ?? false;

    return Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
        onTap: () {
          // Use the static method
          if (game != null) {
            // Just toggle - no need to track state
            PauseButton.toggleGamePause(game);
            // Force rebuild to update the image
            setState(() {});
          }
        },
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                // If the pauseMenu is active change button background
                isPaused
                    ? 'assets/images/PopUps/Buttons/play_pressed.png'
                    : 'assets/images/PopUps/Buttons/pause.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
