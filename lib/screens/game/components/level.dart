import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:guess_the_toilet/screens/game/components/player.dart';

class Level extends World {
  final String levelName;
  final Player player;
  Level({
    required this.levelName,
    required this.player,
  });
  // Variables to store information used in onLoad
  late TiledComponent level;

  @override
  Future<void> onLoad() async {
    // Load the level with modified path
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(32));

    // Add the level to the game
    add(level);

    // Get the spawnpoints layer
    final spawnpointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoint');

    // Based on the position of the spawnpoint tile in Tiled, set the player's position
    if (spawnpointsLayer != null) {
      for (var spawnpoint in spawnpointsLayer.objects) {
        switch (spawnpoint.class_) {
          case "spawnpoint":
            player.position = Vector2(spawnpoint.x + 16, spawnpoint.y + 16);
            add(player);
            print(
                "Spawnpoint found, setting player position to ${player.position}");

            break;
          default:
            throw Exception('Spawnpoint not found');
        }
      }
    } else {
      throw Exception('Spawnpoint layer not found');
    }

    return super.onLoad();
  }
}
