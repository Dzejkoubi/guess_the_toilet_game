import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:guess_the_toilet/screens/game/components/blocks/collision_block.dart';
import 'package:guess_the_toilet/screens/game/components/blocks/level_block.dart';
import 'package:guess_the_toilet/screens/game/components/blocks/npc_block.dart';
import 'package:guess_the_toilet/screens/game/components/player.dart';
import 'package:guess_the_toilet/screens/game/components/blocks/toilet_block.dart';
import 'package:guess_the_toilet/screens/game/guess_the_toilet.dart';
import 'package:guess_the_toilet/services/providers/user_provider.dart';

class GameLevel extends World with HasGameRef<GuessTheToilet> {
  final String levelName;
  final Player player;
  final int levelNumber;
  final int timeLimit;
  final UserProvider userProvider;

  double timeElapsed = 0;

  GameLevel({
    required this.levelName,
    required this.player,
    required this.levelNumber,
    required this.userProvider,
    this.timeLimit = 0,
  });

  @override
  Future<void> onLoad() async {
    try {
      final mapPath = '$levelName.tmx';
      print('Loading map from: $mapPath');

      // Load the level with error handling
      level = await TiledComponent.load(mapPath, Vector2.all(32));

      // Set a very low priority for the map so other elements render on top
      level.priority = 0;

      // Add the level to the game
      await add(level);

      // Extract both collision blocks and toilet blocks in a single pass
      _extractObjectsFromMap();

      // Find spawnpoint and adds player to correct position
      _extractSpawnpointFromMap();

      return super.onLoad();
    } catch (e) {
      print('Error loading map: $e');

      // For non-roadmap levels, return to roadmap immediately
      if (levelName != 'roadmap') {
        game.returnToRoadmap();
      } else {
        // If the roadmap itself fails to load, we have a serious problem
        print('CRITICAL: Failed to load roadmap!');
      }

      // Important: still return to prevent any additional processing
      return;
    }
  }

  // Variables to store information used in onLoad
  late TiledComponent level;

  // Method to get level size
  Vector2 get mapPixelSize {
    final width = level.tileMap.map.width * level.tileMap.map.tileWidth;
    final height = level.tileMap.map.height * level.tileMap.map.tileHeight;
    return Vector2(width.toDouble(), height.toDouble());
  }

  void _extractSpawnpointFromMap() {
    final spawnpointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoint');

    if (spawnpointsLayer != null) {
      for (var spawnpoint in spawnpointsLayer.objects) {
        switch (spawnpoint.class_) {
          case "spawnpoint":

            // Set explicit position for player based on spawnpoint location
            player.position = Vector2(spawnpoint.x, spawnpoint.y);
            print('Set player position to: ${player.position}');

            // Add player to the world
            add(player);

            break;
          default:
            throw Exception('Spawnpoint not found');
        }
      }
    } else {
      print('ERROR: Spawnpoint layer not found in TileMap');
      throw Exception('Spawnpoint layer not found');
    }
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
            player.collisionBlocks.add(collisionBlock);
            add(collisionBlock);
            break;

          case 'toilet_correct':
            // Create a toilet block marked as correct
            final toiletBlock = ToiletBlock(
              position: Vector2(object.x + 1, object.y + 1),
              size: Vector2(object.width - 2, object.height - 2),
              onSelectionChanged: (toilet, isSelected) {
                if (game.debugMode) {
                  print('Toilet selection changed: $isSelected (correct)');
                }
              },
            );
            toiletBlock.markCorrect(); // Set the answer state to correct
            player.toiletBlocks.add(toiletBlock);
            add(toiletBlock);

            // Create an smaller obstacle for not passing throught the toiletblock
            final collisionToiletBlock = CollisionBlock(
              position: Vector2(
                object.x +
                    (object.width / 4) +
                    2, // Offset by 1/4 width to center
                object.y +
                    (object.height / 8) +
                    2, // Offset by 1/4 height to center
              ),
              size: Vector2(
                (object.width / 2) - 4,
                (object.height * 6 / 8) - 4,
              ),
            );
            player.collisionBlocks.add(collisionToiletBlock);
            add(collisionToiletBlock);
            break;

          case 'toilet_wrong':
            // Create a toilet block marked as wrong
            final toiletBlock = ToiletBlock(
              position: Vector2(object.x + 1, object.y + 1),
              size: Vector2(object.width - 2, object.height - 2),
              onSelectionChanged: (toilet, isSelected) {
                if (game.debugMode) {
                  print('Toilet selection changed: $isSelected (wrong)');
                }
              },
            );
            toiletBlock.markWrong(); // Set the answer state to wrong
            player.toiletBlocks.add(toiletBlock);
            add(toiletBlock);
            // Create an smaller obstacle for not passing throught the toiletblock
            final collisionToiletBlock = CollisionBlock(
              position: Vector2(
                object.x +
                    (object.width / 4) +
                    2, // Offset by 1/4 width to center
                object.y +
                    (object.height / 8) +
                    2, // Offset by 1/4 height to center
              ),
              size: Vector2(
                (object.width / 2) - 4,
                (object.height * 6 / 8) - 4,
              ),
            );
            player.collisionBlocks.add(collisionToiletBlock);
            add(collisionToiletBlock);
            break;
          case 'npc_slim':
            // Create a NPC block with slim hitbox
            final collisionNpcBlock = CollisionBlock(
              position: Vector2(
                object.x + (object.width * 5 / 16) + 1,
                object.y + 1,
              ),
              size: Vector2(
                (object.width * 6 / 16) - 2,
                object.height - 2,
              ),
            );
            player.collisionBlocks.add(collisionNpcBlock);
            add(collisionNpcBlock);
            final npcBlock = NpcBlock(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
              npcType: NpcType.slim,
            );
            player.npcBlocks.add(npcBlock);
            add(npcBlock);
            break;
          case 'npc_wide':
            // Create a NPC block with wide hitbox
            final collisionNpcBlock = CollisionBlock(
              position: Vector2(
                object.x + (object.width * 3 / 16) + 1,
                object.y + 1,
              ),
              size: Vector2(
                (object.width * 10 / 16) - 2,
                object.height - 2,
              ),
            );
            player.collisionBlocks.add(collisionNpcBlock);
            add(collisionNpcBlock);
            final npcBlock = NpcBlock(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
              npcType: NpcType.wide,
            );
            player.npcBlocks.add(npcBlock);
            add(npcBlock);

            break;
          case 'level_block':
            // Create a generic NPC block
            final collisionLevelBlock = CollisionBlock(
              position: Vector2(
                object.x + 3,
                object.y + 3,
              ),
              size: Vector2(
                object.width - 6,
                object.height - 6,
              ),
            );
            player.collisionBlocks.add(collisionLevelBlock);
            add(collisionLevelBlock);

            // Get the level_number property from Tiled
            final levelNumber = object.properties.first.value as int;

            LevelState levelState;
            if (levelNumber < userProvider.currentLevel) {
              levelState = LevelState.completed;
            } else if (levelNumber == userProvider.currentLevel) {
              levelState = LevelState.incomplete;
            } else {
              levelState = LevelState.locked;
            }
            if (game.debugMode) {
              print(
                  'Creating level block $levelNumber with state: $levelState (current user level: ${userProvider.currentLevel})');
            }
            final levelBlock = LevelBlock(
              position: Vector2(object.x, object.y),
              levelState: levelState,
            );
            player.levelBlocks.add(levelBlock);
            add(levelBlock);
            break;
        }
      }
    } else {
      print('Warning: No "Objects" layer found in the Tiled map');
    }
  }
}
