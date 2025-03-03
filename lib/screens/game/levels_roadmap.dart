import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/constants/game_constants.dart';
import 'package:guess_the_toilet/screens/game/roadmap_components/level_node.dart';
import 'package:guess_the_toilet/theme/theme.dart';

class RoadmapGame extends FlameGame {
  RoadmapGame() : super(camera: CameraComponent.withFixedResolution(
    width: GameConstants.gameWidth,
    height: GameConstants.gameHeight,
  ));

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
        world.add(
      LevelNode(
          position: Vector2(GameConstants.gameWidth/4, GameConstants.gameHeight/2), radius: GameConstants.gameWidth/4, color: Colors.yellow),
    );
    world.add(
      LevelNode(
          position: Vector2(-GameConstants.gameWidth/4, 0), radius: GameConstants.gameWidth/4, color: Colors.black),
    );

  }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   // Handle game updates (e.g., animations, level selection)
  // }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   // Render the roadmap UI (this will be developed step by step)
  // }

  @override
  Color backgroundColor() {
    return AppTheme.primaryColor;
  }
}
