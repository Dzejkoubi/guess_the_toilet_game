import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_toilet/screens/game/guess_the_toilet.dart';

class EActionButton extends StatefulWidget {
  static const String id = 'EActionButton';
  final GuessTheToilet game;

  const EActionButton({Key? key, required this.game}) : super(key: key);

  @override
  State<EActionButton> createState() => _EActionButtonState();
}

class _EActionButtonState extends State<EActionButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      right: 80,
      child: GestureDetector(
        onTap: () {
          // Update state and trigger the key event
          setState(() {
            isPressed = true;
          });

          // Simulate E key press
          final keyEvent = KeyDownEvent(
            timeStamp: Duration.zero,
            physicalKey: PhysicalKeyboardKey.keyE,
            logicalKey: LogicalKeyboardKey.keyE,
            character: 'e',
          );
          // Forward the key event to the game's key handler
          widget.game.onKeyEvent(
            keyEvent,
            {LogicalKeyboardKey.keyE},
          );
          print('E Button pressed');

          // Reset button state after a short delay
          Future.delayed(const Duration(milliseconds: 50), () {
            if (mounted) {
              setState(() {
                isPressed = false;
              });
            }
          });
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isPressed
                    ? 'assets/images/PopUps/Buttons/e_button_pressed.png'
                    : 'assets/images/PopUps/Buttons/e_button.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
