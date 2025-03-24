import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/screens/guess_the_toilet_game/components/player.dart';
import 'package:guess_the_toilet/screens/guess_the_toilet_game/components/level.dart';

class GuessTheToilet extends FlameGame {
  @override
  Color backgroundColor() => Color(0xFFF5F5F5);

  late CameraComponent cam;
  late GameLevel level;
  late Player player;

  @override
  FutureOr<void> onLoad() async {
    // Loads all images
    await images.loadAllImages();

    // Initilaze player
    final Player player = Player();
    // Initilaze the camera first with simple settings
    final cam = CameraComponent.withFixedResolution(
      height: 288,
      width: 160,
    );
    add(cam);

    // Create and add the level with camera
    final GameLevel level =
        GameLevel(player: player, levelName: 'lvl_2', camera: cam);
    cam.world = level;
    add(level);

    return super.onLoad();
  }
}
