import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:guess_the_toilet/screens/game/components/collision_block.dart';
import 'package:guess_the_toilet/screens/game/components/player.dart';
import 'package:guess_the_toilet/screens/game/components/toilet_block.dart';

class Level extends World {
  final String levelName;
  final Player player;

  // List to store collision blocks
  final List<CollisionBlock> collisionBlocks = [];
  final List<ToiletBlock> toiletBlocks = [];

  Level({
    required this.levelName,
    required this.player,
  }) {
    debugMode = false;
  }

  // Variables to store information used in onLoad
  late TiledComponent level;

  @override
  Future<void> onLoad() async {
    // Load the level with modified path
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(32));

    // Add the level to the game
    add(level);

    // Extract both collision blocks and toilet blocks in a single pass
    _extractObjectsFromMap();

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

            // Pass toilet blocks to player for interaction
            player.toiletBlocks = toiletBlocks;

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

  // Extract both collision blocks and toilet blocks from the Tiled map in a single pass
  void _extractObjectsFromMap() {
    // Get the Objects layer containing all interactive objects
    final objectsLayer = level.tileMap.getLayer<ObjectGroup>('Objects');

    if (objectsLayer != null) {
      for (final object in objectsLayer.objects) {
        switch (object.class_) {
          case 'obstacle':
            // Create a collision block
            final collisionBlock = CollisionBlock(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
            );
            collisionBlocks.add(collisionBlock);
            add(collisionBlock);
            break;

          case 'toilet_correct':
            // Create a toilet block marked as correct
            final toiletBlock = ToiletBlock(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
            );
            // Callback to print isSelected state when changed
            onSelectionChanged:
            (toilet, isSelected) {
              if (debugMode) {
                print(
                    'Toilet ${toilet.toiletId} selection changed: $isSelected');
              }
            };
            toiletBlock.markCorrect(); // Set the answer state to correct
            toiletBlocks.add(toiletBlock);
            add(toiletBlock);
            break;

          case 'toilet_wrong':
            // Create a toilet block marked as wrong
            final toiletBlock = ToiletBlock(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
            );
            onSelectionChanged:
            (toilet, isSelected) {
              if (debugMode) {
                print(
                    'Toilet ${toilet.toiletId} selection changed: $isSelected');
              }
            };

            toiletBlock.markWrong(); // Set the answer state to wrong
            toiletBlocks.add(toiletBlock);
            add(toiletBlock);
            break;
        }
      }

      if (debugMode) {
        print(
            'Extracted ${collisionBlocks.length} collision blocks and ${toiletBlocks.length} toilet blocks from the map');
      }
    } else {
      print('Warning: No "Objects" layer found in the Tiled map');
    }
  }
}
