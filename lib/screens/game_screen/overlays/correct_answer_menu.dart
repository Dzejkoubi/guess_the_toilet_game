import 'package:flutter/material.dart';
import 'package:guess_the_toilet/screens/game/guess_the_toilet.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_menu.dart';

class CorrectAnswerMenu extends StatelessWidget {
  static const String id = 'CorrectAnswerMenu';
  // Passes gameRef for the WrongButtonButton to execute funcitons from Game widget
  final GuessTheToilet gameRef;

  const CorrectAnswerMenu({super.key, required this.gameRef});

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
              image: AssetImage('assets/images/PopUps/answer_correct.png'),
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
                    PauseMenuButton(
                        buttonType: ButtonType.nextLevel, gameRef: gameRef),
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
