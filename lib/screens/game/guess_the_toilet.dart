import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_camera_tools/flame_camera_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_toilet/screens/game/components/level.dart';
import 'package:guess_the_toilet/screens/game/components/player.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/correct_answer_menu.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_button.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_menu.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/time_indicator.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/wrong_answer_menu.dart';

class GuessTheToilet extends FlameGame
    with KeyboardEvents, HasCollisionDetection {
  // Declare class fields
  late Player player;
  late CameraComponent cam;
  late GameLevel level;

  @override
  Color backgroundColor() => Colors.white;

  // **Level switching variables**

  // Number of levels
  // This is the number of levels in the game, not including the roadmap
  // The roadmap is level 0, so the number of levels is 10
  int numberOfLevels = 10; // Total number of levels
  int currentLevelIndex = 0; // Level the player is currently in (0 is roadmap)
  bool _isPlayerOnRoadmap = true;
  bool get isPlayerOnRoadmap => _isPlayerOnRoadmap;
  static const String roadmapLevelName = 'roadmap';

  // Popup menus
  final pauseOverlayIdentifier = PauseMenu.id;
  final pauseButtonOverlayIdentifier = PauseButton.id;
  final correctOverlayIdentifier = CorrectAnswerMenu.id;
  final wrongOverlayIdentifier = WrongAnswerMenu.wrongAnswerId;
  final timeIsUpOverlayIdentifier =
      WrongAnswerMenu.timeIsUpId; // Time is up overlay

  // Getter to if the game is paused
  bool get isGamePaused => overlays.isActive(pauseOverlayIdentifier);

  @override
  Future<void> onLoad() async {
    try {
      // Clear all overlays and play engine
      resumeEngine();
      overlays.clear();
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

  // **Moving across levels and roadmap**
  // Private method to handle common level loading functionality so the code does not repeats its self in
  Future<void> _loadLevel({
    required String levelName,
    required int levelIndex,
    required bool isRoadmap,
  }) async {
    try {
      // Clear all overlays and play engine
      resumeEngine();
      overlays.clear();

      // First remove the level and reset the player so new one can be inserted
      remove(level);
      player.reset();

      // Set the index of level
      currentLevelIndex = levelIndex;
      _isPlayerOnRoadmap = isRoadmap;

      // Create new player and level
      player = Player();
      level = GameLevel(levelName: levelName, player: player);

      // Add the level
      await add(level);

      // Set up camera
      cam.world = level;
      cam.viewfinder.position = Vector2.zero();
      cam.smoothFollow(
        player,
        stiffness: 3,
      );

      // Set the index of level
      currentLevelIndex = levelIndex;
      _isPlayerOnRoadmap = isRoadmap;

      // Initialize timer for non-roadmap levels
      if (!isRoadmap && levelIndex < levelTimeLimits.length) {
        int timeLimit = levelTimeLimits[levelIndex];
        startTimer(timeLimit);

        // Add time indicator overlay
        overlays.add(TimeIndicator.id);
      } else {
        // No timer for roadmap
        stopTimer();
        overlays.remove(TimeIndicator.id);
      }

      // Only add pause button for non-roadmap levels
      if (!isRoadmap) {
        overlays.add(PauseButton.id);
      }
    } catch (e) {
      if (debugMode) {
        print('Error loading level "$levelName": $e');
      }
    }
  }

  // Simplif
  void openLevel({int levelNumber = 0}) async {
    if (debugMode) {
      print('Opening level $levelNumber');
    }

    final String levelName =
        levelNumber == 0 ? roadmapLevelName : 'lvl_$levelNumber';

    await _loadLevel(
      levelName: levelName,
      levelIndex: levelNumber,
      isRoadmap: levelNumber == 0,
    );
  }

  void nextLevel() async {
    final nextLevelIndex = currentLevelIndex + 1;

    if (debugMode) {
      print('Moving to next level: $nextLevelIndex');
    }

    // Check if we've exceeded max levels
    if (nextLevelIndex > numberOfLevels) {
      print('No more levels, returning to roadmap');
      returnToRoadmap();
      return;
    }

    final String levelName = 'lvl_$nextLevelIndex';

    await _loadLevel(
      levelName: levelName,
      levelIndex: nextLevelIndex,
      isRoadmap: false,
    );
  }

  void returnToRoadmap() async {
    if (debugMode) {
      print('Opening roadmap');
    }

    await _loadLevel(
      levelName: roadmapLevelName,
      levelIndex: 0,
      isRoadmap: true,
    );
  }

  // Time limits for each level
  List<int> levelTimeLimits = [
    15, // Roadmap
    30, // Level 1
    30, // Level 2
    30, // Level 3
    30, // Level 4
    45, // Level 5
    45, // Level 6
    45, // Level 7
    60, // Level 8
    60, // Level 9
    120, // Level 10
  ];
  double _timeRemaining = 0;
  double get time => _timeRemaining;
  bool timerActive = false;

  // Time handling in update method
  @override
  void update(double dt) {
    super.update(dt);

    // Only update time in non-roadmap levels and when timer is active
    if (!_isPlayerOnRoadmap && timerActive) {
      if (_timeRemaining > 0) {
        _timeRemaining -= dt;

        // Force rebuild of the TimeIndicator overlay to update the UI
        if (overlays.isActive(TimeIndicator.id)) {
          overlays.remove(TimeIndicator.id);
          overlays.add(TimeIndicator.id);
        }

        // Check for time up
        if (_timeRemaining <= 0) {
          _timeRemaining = 0;
          timerActive = false;
          showTimeIsUpOverlay();
        }
      }
    }
  }

// Method to start timer
  void startTimer(int seconds) {
    _timeRemaining = seconds.toDouble();
    timerActive = true;

    // Add time indicator overlay if not already added
    if (!overlays.isActive(TimeIndicator.id)) {
      overlays.add(TimeIndicator.id);
    }
  }

// Method to stop timer
  void stopTimer() {
    timerActive = false;
  }

// Show time's up overlay
  void showTimeIsUpOverlay() {
    pauseEngine();
    overlays.add(timeIsUpOverlayIdentifier);
  }

  // Apply time penalty when player touches an NPC
  void applyTimePenalty(int seconds) {
    // Only apply penalty if we're in a level with active timer
    if (!_isPlayerOnRoadmap && timerActive && _timeRemaining > 0) {
      // Decrease time by penalty amount
      _timeRemaining -= seconds;

      // Make sure we don't go below zero
      if (_timeRemaining <= 0) {
        _timeRemaining = 0;
        timerActive = false;
        showTimeIsUpOverlay();
      }

      // Force rebuild of the TimeIndicator overlay to immediately update the UI
      if (overlays.isActive(TimeIndicator.id)) {
        overlays.remove(TimeIndicator.id);
        overlays.add(TimeIndicator.id);
      }
    }
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
