import 'package:flutter/material.dart';
import 'package:guess_the_toilet/screens/game/guess_the_toilet.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_menu.dart';

class WrongAnswerMenu extends StatelessWidget {
  static const String wrongAnswerId = 'WrongAnswerMenu';
  static const String timeIsUpId = 'TimeIsUpMenu';
  // Passes gameRef for the WrongButtonButton to execute funcitons from Game widget
  final GuessTheToilet gameRef;

  final String? text;

  const WrongAnswerMenu({super.key, required this.gameRef, this.text});

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
              image: AssetImage('assets/images/PopUps/answer_wrong.png'),
              fit: BoxFit.contain,
            ),
          ),

          // Add padding to position buttons properly
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 128, // Add space at the bottom
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text widget to display the text
                    if (text != null)
                      Text(
                        text!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'dpcomic',
                        ),
                      ),
                  ],
                ),
                Expanded(child: Container()),
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
