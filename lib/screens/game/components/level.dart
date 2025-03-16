import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  String levelName;
  Level({
    required this.levelName,
  });
  // Variables to store information used in onLoad
  late TiledComponent level;

  @override
  Future<void> onLoad() async {
    // Load the level with modified path
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(32),
        // Add a prefix to fix the relative paths
        prefix: 'assets/tiles/');

    // Register image paths if needed for tiled references
    // This might be necessary depending on your TMX file structure

    // Adds used components to the game
    add(level);
    return super.onLoad();
  }
}
