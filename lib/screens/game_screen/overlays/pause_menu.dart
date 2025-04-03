import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  static const String id = 'PauseMenu';

  const PauseMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 960,
        width: 640,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/PopUps/game_paused.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

enum ButtonType {
  goToRoadmap,
  restart,
  nextLevel,
}

class PauseMenuButton extends StatelessWidget {
  final ButtonType buttonType;

  const PauseMenuButton({super.key, required this.buttonType});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
        onTap: () {
          if (buttonType == ButtonType.goToRoadmap) {
          } else if (buttonType == ButtonType.nextLevel) {
          } else if (buttonType == ButtonType.restart) {}
        },
        child: Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/PopUps/Buttons/pause.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
