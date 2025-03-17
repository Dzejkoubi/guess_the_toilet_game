import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:guess_the_toilet/screens/game/components/collision_block.dart';
import 'package:guess_the_toilet/screens/game/components/player.dart';

class Level extends World {
  final String levelName;
  final Player player;

  // List to store collision blocks
  final List<CollisionBlock> collisionBlocks = [];

  Level({
    required this.levelName,
    required this.player,
  }) {
    debugMode = true;
  }

  // Variables to store information used in onLoad
  late TiledComponent level;

  @override
  Future<void> onLoad() async {
    // Load the level with modified path
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(32));

    // Add the level to the game
    add(level);

    // Extract and add collision blocks from the Tiled map
    _extractCollisionBlocks();

    // Get the spawnpoints layer
    final spawnpointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoint');

    // Based on the position of the spawnpoint tile in Tiled, set the player's position
    if (spawnpointsLayer != null) {
      for (var spawnpoint in spawnpointsLayer.objects) {
        switch (spawnpoint.class_) {
          case "spawnpoint":
            player.position = Vector2(spawnpoint.x, spawnpoint.y);

            // Pass the collision blocks to the player for collision detection
            player.collisionBlocks = collisionBlocks;

            add(player);
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

  // Extract collision blocks from the Tiled map
  void _extractCollisionBlocks() {
    // Get the Objects layer containing obstacles
    final objectsLayer = level.tileMap.getLayer<ObjectGroup>('Objects');

    if (objectsLayer != null) {
      for (final object in objectsLayer.objects) {
        if (object.class_ == 'obstacle') {
          // Create a collision block for each obstacle
          final collisionBlock = CollisionBlock(
            position: Vector2(object.x, object.y),
            size: Vector2(object.width, object.height),
          );

          // Add the collision block to our list and to the game world
          collisionBlocks.add(collisionBlock);
          add(collisionBlock);
          // if (debugMode) {
          //   print(
          //       'Added collision block at ${collisionBlock.position} with size ${collisionBlock.size}');
          // }
        }
      }
      // if (debugMode) {
      //   print(
      //       'Extracted ${collisionBlocks.length} collision blocks from the map');
      // }
    } else {
      print('Warning: No "Objects" layer found in the Tiled map');
    }
  }
}
