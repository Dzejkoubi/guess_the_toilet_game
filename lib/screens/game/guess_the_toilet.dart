import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_camera_tools/flame_camera_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_toilet/screens/game/components/level.dart';
import 'package:guess_the_toilet/screens/game/components/player.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/correct_answer.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_button.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_menu.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/wrong_answer.dart';

class GuessTheToilet extends FlameGame
    with KeyboardEvents, HasCollisionDetection {
  // Declare class fields
  late Player player;
  late CameraComponent cam;
  late GameLevel level;

  @override
  Color backgroundColor() => Colors.white;

  // Level switching variables
  int numberOfLevels = 10; // Total number of levels
  int currentLevelIndex = 0; // Level the player is currently in (0 is roadmap)
  bool _isPlayerOnRoadmap = true;
  static const String roadmapLevelName = 'roadmap';

  // Popup menus
  final pauseOverlayIdentifier = PauseMenu.id;
  final pauseButtonOverlayIdentifier = PauseButton.id;
  final correctOverlayIdentifier = CorrectAnswer.id;
  final wrongOverlayIdentifier = WrongAnswer.id;

  @override
  Future<void> onLoad() async {
    try {
      // Load all images
      await images.loadAllImages();

      // Initialize class fields directly
      player = Player(defaultState: PlayerState.idleDown);

      // Create a level(roadmap by default) and add it to the world
      try {
        level = GameLevel(
            player: player, levelName: roadmapLevelName, timeLimit: 0);
        add(level);
      } catch (e) {
        print('Failed to load roadmap: $e');
        // Create a simple fallback level
        level = GameLevel.createFallbackLevel(player: player);
        add(level);
      }

      cam = CameraComponent.withFixedResolution(
        height: 288,
        width: 162,
        world: level,
      );
      cam.smoothFollow(
        player,
        stiffness: 3,
      );
      add(cam);
    } catch (e) {
      print('Error in onLoad: $e');
      rethrow;
    }
    debugMode = true;

    return super.onLoad();
  }

  void openLevel({int levelNumber = 0}) async {
    try {
      if (debugMode) {
        print('Opening level $levelNumber');
      }
      //First remove the level and reset the player so new one can be inserted
      remove(level);
      player.reset();

      // Set the index of level to the number passed from function
      currentLevelIndex = levelNumber;

      // Set level name based on level number
      String levelName;

      if (levelNumber == 0) {
        levelName = roadmapLevelName;
        _isPlayerOnRoadmap = true;
      } else {
        levelName = 'lvl_$levelNumber';
        _isPlayerOnRoadmap = false;
      }
      player = Player();
      level = GameLevel(levelName: levelName, player: player);

      // Add the level
      await add(level);

      // When the level loads add the camera
      cam.world = level;
      // Update the camera to follow the player in the new level
      cam.viewfinder.position = Vector2.zero();
      cam.smoothFollow(
        player,
        stiffness: 3,
      );
    } catch (e) {
      if (debugMode) {
        print('Error opening level: $levelNumber: $e');
      }
    }
  }

  void nextLevel() async {
    try {
      if (debugMode) {
        print('Restarting level: $currentLevelIndex');
      }
      //First remove the level and reset the player so new one can be inserted
      remove(level);
      player.reset();

      // Set the index of level to the number passed from function
      currentLevelIndex += 1;

      // Set level name based on level number
      String levelName;

      if (currentLevelIndex == 0) {
        levelName = roadmapLevelName;
        _isPlayerOnRoadmap = true;
      } else {
        levelName = 'lvl_$currentLevelIndex';
        _isPlayerOnRoadmap = false;
      }
      player = Player();
      level = GameLevel(levelName: levelName, player: player);

      // Add the level
      await add(level);

      // When the level loads add the camera
      cam.world = level;
      // Update the camera to follow the player in the new level
      cam.viewfinder.position = Vector2.zero();
      cam.smoothFollow(
        player,
        stiffness: 3,
      );
    } catch (e) {
      if (debugMode) {
        print('Error opening level: $currentLevelIndex: $e');
      }
    }
  }

  void returnToRoadmap() {
    openLevel(levelNumber: 0);
  }

  // Handle key events and forward them to the player to control movement
  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    // Use the class field directly instead of looking it up
    if (player.onKeyEvent(event, keysPressed)) {
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
