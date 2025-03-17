import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_toilet/app/constants/style_constants.dart';
import 'package:guess_the_toilet/screens/game/components/level.dart';
import 'package:guess_the_toilet/screens/game/components/player.dart';

class GuessTheToilet extends FlameGame with KeyboardEvents {
  @override
  Color backgroundColor() => AppConstants.backgroundColor;

  late final CameraComponent cam;

  // Create player with an optional default state

  @override
  Future<void> onLoad() async {
    try {
      // Ensure all images are loaded before proceeding
      await images.loadAllImages();

      // Create the player with a specific default state
      final Player player = Player(defaultState: PlayerState.idleLeft);

      // Create the game world with player and specified default state
      final World world = Level(
        levelName: 'lvl_1',
        player: player,
      );

      cam = CameraComponent.withFixedResolution(
        height: 256,
        width: 160,
        world: world,
      );
      cam.priority = 1;
      cam.viewfinder.anchor = Anchor.topLeft;

      addAll([
        world,
        cam,
      ]);
    } catch (e) {
      print('Error in onLoad: $e');
      rethrow;
    }
    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    // Get a reference to the player from the game world
    final player = children.whereType<Level>().first.player;

    // Forward key events to the player
    if (player.onKeyEvent(event, keysPressed)) {
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
