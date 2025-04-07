import 'package:flutter/material.dart';
import 'package:guess_the_toilet/screens/game/guess_the_toilet.dart';

class PauseMenu extends StatelessWidget {
  static const String id = 'PauseMenu';
  // Passes gameRef for the PauseMenuButton to execute funcitons from Game widget
  final GuessTheToilet gameRef;

  const PauseMenu({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.black.withOpacity(0.7),
      ),
      Center(
        child: Container(
          height: 960,
          width: 640,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/PopUps/game_paused.png'),
              fit: BoxFit.contain,
            ),
          ),

          // Add padding to position buttons properly
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 128, // Add space at the bottom
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Button row with proper spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PauseMenuButton(
                        buttonType: ButtonType.goToRoadmap, gameRef: gameRef),
                    PauseMenuButton(
                        buttonType: ButtonType.restart, gameRef: gameRef),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

enum ButtonType {
  goToRoadmap,
  restart,
  nextLevel,
}

class PauseMenuButton extends StatelessWidget {
  final ButtonType buttonType;
  final GuessTheToilet gameRef;

  const PauseMenuButton(
      {super.key, required this.buttonType, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (buttonType) {
          case ButtonType.goToRoadmap:
            gameRef.returnToRoadmap();
            break;
          case ButtonType.nextLevel:
            gameRef.nextLevel();
          case ButtonType.restart:
            gameRef.openLevel(levelNumber: gameRef.currentLevelIndex);
        }
      },
      child: Container(
        width: 128,
        height: 128,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: switch (buttonType) {
              ButtonType.goToRoadmap =>
                AssetImage('assets/images/PopUps/Buttons/home_pressed.png'),
              ButtonType.restart =>
                AssetImage('assets/images/PopUps/Buttons/restart_pressed.png'),
              ButtonType.nextLevel =>
                AssetImage('assets/images/PopUps/Buttons/play_pressed.png'),
            },
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
