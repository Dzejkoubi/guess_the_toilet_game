import 'dart:ui';

import 'package:flame/game.dart';
import 'package:guess_the_toilet/screens/game/level_node.dart';

class RoadmapGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    List<LevelNode> levelNodes = [
      LevelNode(levelNumber: 1, isUnlocked: true),
      LevelNode(levelNumber: 2, isUnlocked: false),
      LevelNode(levelNumber: 3, isUnlocked: false),
      LevelNode(levelNumber: 4, isUnlocked: false),
    ];
    addAll(levelNodes);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Handle game updates (e.g., animations, level selection)
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Render the roadmap UI (this will be developed step by step)
  }
}
