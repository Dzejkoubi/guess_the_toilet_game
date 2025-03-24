import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_camera_tools/flame_camera_tools.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/screens/guess_the_toilet_game/components/blocks/collision_block.dart';
import 'package:guess_the_toilet/screens/guess_the_toilet_game/components/blocks/toilet_block.dart';
import 'package:guess_the_toilet/screens/guess_the_toilet_game/components/player.dart';

class GameLevel extends World {
  final Player player;
  final String levelName;
  final CameraComponent camera;
  GameLevel({
    required this.player,
    required this.levelName,
    required this.camera,
  }) {
    debugMode = true;
  }
  late TiledComponent level;

  Vector2 get mapPixelSize {
    final width = level.tileMap.map.width * level.tileMap.map.tileWidth;
    final height = level.tileMap.map.height * level.tileMap.map.tileHeight;
    print('Level Width: $width, Level Height: $height');
    return Vector2(width.toDouble(), height.toDouble());
  }

  @override
  FutureOr<void> onLoad() async {
    // Load the level
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(32));
    add(level);

    // Extract object groups
    _extractObjectsFromMap();
    // Spawn player
    _spawnPlayer();

    return super.onLoad();
  }

  // Finds spawnpoint location and place player here
  void _spawnPlayer() {
    // Gets spawnpoint and adds player to the level
    final spawnpointsLayer = level.tileMap.getLayer<ObjectGroup>("Spawnpoint");
    if (spawnpointsLayer != null) {
      for (var spawnpoint in spawnpointsLayer.objects) {
        switch (spawnpoint.class_) {
          case "spawnpoint":
            player.position = Vector2(spawnpoint.x, spawnpoint.x);
            player.size = Vector2(spawnpoint.width, spawnpoint.height);
            print(
                'Added player \n Position: x:${spawnpoint.x}, y:${spawnpoint.y} \n Size: width:${spawnpoint.width}, height${spawnpoint.height}');
            add(player);
            break;
          default:
            throw Exception('Spawnpoint was not found in spawnpoint layer');
        }
      }
    } else {
      throw Exception('Spawnpoint layer was not found');
    }
  }

  // Add reference to collision blocks
  List<CollisionBlock> collisionBlocks = [];

  // Add reference to toilet blocks
  List<ToiletBlock> toiletBlocks = [];

  // Extract object groups (obstacle, correct_toilet, wrong_toilet) from the Objects layer
  void _extractObjectsFromMap() {
    final objectsLayer = level.tileMap.getLayer<ObjectGroup>("Objects");

    if (objectsLayer != null) {
      for (var object in objectsLayer.objects) {
        switch (object.class_) {
          case "obstacle":
            final collisionBlock = CollisionBlock(
                position: Vector2(object.x, object.y),
                size: Vector2(
                  object.width,
                  object.height,
                ));
            collisionBlocks.add(collisionBlock);
            add(collisionBlock);

            break;
          case 'toilet_correct':
            // Create a toilet block marked as correct
            final toiletBlock = ToiletBlock(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
              onSelectionChanged: (toilet, isSelected) {
                if (debugMode) {
                  print('Toilet selection changed: $isSelected (correct)');
                }
              },
            );
            toiletBlock.markCorrect(); // Set the answer state to correct
            toiletBlocks.add(toiletBlock);
            add(toiletBlock);
            break;
          case 'toilet_wrong':
            // Create a toilet block marked as wrong
            final toiletBlock = ToiletBlock(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
              onSelectionChanged: (toilet, isSelected) {
                if (debugMode) {
                  print('Toilet selection changed: $isSelected (wrong)');
                }
              },
            );
            toiletBlock.markWrong(); // Set the answer state to wrong
            toiletBlocks.add(toiletBlock);
            add(toiletBlock);
            break;
        }
      }
      if (debugMode) {
        print(
            'Obstacles: ${collisionBlocks.length} \n ${toiletBlocks.length})} toilet blocks from the map');
      }
    } else {
      print('Warning: No "Objects" layer found in the Tiled map');
    }
  }

  @override
  void onMount() {
    super.onMount();
    final levelHeight = level.tileMap.map.height * level.tileMap.map.tileHeight;
    final levelWidth = level.tileMap.map.height * level.tileMap.map.tileWidth;

    camera.smoothFollow(player,
        stiffness: 2,
        deadZone: Rect.fromLTWH(
          0,
          0,
          levelWidth.toDouble(),
          levelHeight.toDouble(),
        ));
    camera.viewfinder.anchor = Anchor.topLeft;
  }
}
