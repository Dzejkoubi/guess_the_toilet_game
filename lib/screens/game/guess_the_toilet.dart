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
  Player player = Player();

  @override
  Future<void> onLoad() async {
    try {
      // Ensure all images are loaded before proceeding
      await images.loadAllImages();

      // Create the player first but don't add it yet
      // The player will be added by the Level component
      @override
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
}
