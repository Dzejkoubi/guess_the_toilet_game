import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_camera_tools/flame_camera_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_toilet/app/constants/style_constants.dart';
import 'package:guess_the_toilet/screens/game/components/level.dart';
import 'package:guess_the_toilet/screens/game/components/player.dart';

class GuessTheToilet extends FlameGame with KeyboardEvents {
  // Declare class fields
  late Player player;
  late CameraComponent cam;
  late GameLevel level;

  @override
  Color backgroundColor() => AppConstants.backgroundColor;

  @override
  Future<void> onLoad() async {
    try {
      // Load all images
      await images.loadAllImages();

      // Initialize class fields directly
      player = Player(defaultState: PlayerState.idleLeft);

      level = GameLevel(player: player, levelName: 'lvl_2');
      add(level);

      cam = CameraComponent.withFixedResolution(
        height: 288,
        width: 160,
        world: level,
      );
      cam.smoothFollow(player,
          stiffness: 2,
          deadZone: Rect.fromLTWH(
            0,
            0,
            0,
            0,
          ));
      add(cam);
    } catch (e) {
      print('Error in onLoad: $e');
      rethrow;
    }
    return super.onLoad();
  }

  // Handle key events and forward them to the player to control movement
  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    // Use the class field directly instead of looking it up
    if (player.onKeyEvent(event, keysPressed)) {
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
