import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_toilet/screens/game/components/blocks/collision_block.dart';
import 'package:guess_the_toilet/screens/game/components/blocks/level_block.dart';
import 'package:guess_the_toilet/screens/game/components/blocks/npc_block.dart';
import 'package:guess_the_toilet/screens/game/components/blocks/toilet_block.dart';
import 'package:guess_the_toilet/screens/game/components/level.dart';
import 'package:guess_the_toilet/screens/game/guess_the_toilet.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/correct_answer_menu.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_button.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_menu.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/wrong_answer_menu.dart';
import 'package:guess_the_toilet/services/providers/user_provider.dart';

enum PlayerState {
  idleDown,
  idleLeft,
  idleRight,
  idleUp,
  walkDown,
  walkLeft,
  walkRight,
  walkUp,
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<GuessTheToilet>, KeyboardHandler, CollisionCallbacks {
  final PlayerState defaultState;

  Player({
    Vector2? position,
    this.defaultState = PlayerState.idleDown,
  }) : super(
          position: position,
          size: Vector2.all(32),
          anchor: Anchor.topLeft,
        );

  UserProvider _userProvider = UserProvider();

  @override
  Future<void> onLoad() async {
    try {
      // Load all animation
      _loadAllAnimations();
    } catch (e) {
      print('Error loading player assets: $e');
      rethrow;
    }
    playerDirection = defaultState;

    // Adding hitbox for player for detection using collisionCallbacks
    final playerHitbox = RectangleHitbox(
      position: Vector2(
        size.x / 4, // Offset by 1/4 width to center
        size.y / 2, // Offset by 1/4 height to center
      ),
      size: Vector2(
        size.x / 2,
        size.y / 2,
      ),

      anchor: Anchor.topLeft, // Set anchor to center of hitbox
    );
    add(playerHitbox);

    return super.onLoad();
  }

  // Animations
  late final SpriteAnimation idleDownAnimation;
  late final SpriteAnimation idleLeftAnimation;
  late final SpriteAnimation idleRightAnimation;
  late final SpriteAnimation idleUpAnimation;
  late final SpriteAnimation walkDownAnimation;
  late final SpriteAnimation walkLeftAnimation;
  late final SpriteAnimation walkRightAnimation;
  late final SpriteAnimation walkUpAnimation;
  double idleStepTime = 0.15;
  double walkingStepTime = 0.1;

  // Movement variables
  double speed = 70;
  Vector2 movement = Vector2.zero();
  late PlayerState
      playerDirection; // Saves last activated PlayerState for the use of changing to idle

  // ** Collisions **
  // Collision blocks so player can't pass through them
  List<CollisionBlock> collisionBlocks = [];
  List<ToiletBlock> get getCollisionBlock => toiletBlocks;

  // Toilet blocks for answering
  final List<ToiletBlock> toiletBlocks = [];
  List<ToiletBlock> get getToiletBlocks => toiletBlocks;

  // NPC blocks for interaction
  final List<NpcBlock> npcBlocks = [];

  /*
  Level blocks in roadmap. The order of the blocks is important,
  because it is used to determine the order of the levels
  and the level state (completed, incomplete, locked)
  */
  List<LevelBlock> levelBlocks = [];

  // Check if player is in penalty cooldown so he can't be penalized again (2 seconds)
  bool _penaltyCooldown = false;

  // ** Key handling **

  // Pressed keys
  final Set<LogicalKeyboardKey> _keysPressed = {};

  // Handles key events like: walking
  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Check for key E pressed for interaction
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyE) {
        // Handle toilet interaction
        for (final toilet in toiletBlocks) {
          if (toilet.isSelected) {
            if (game.debugMode) {
              print(
                  'Answering toilet on Toilet block collision detected with \n X: ${toilet.position.x},\n Y: ${toilet.position.y}');
            }
            // Call the answer function
            answer(toilet);
            return true;
          }
        }

        // Handle level selection
        final selectedLevelIndex =
            levelBlocks.indexWhere((levelBlock) => levelBlock.isSelected);
        // First check if any level block is selected
        if (selectedLevelIndex != -1) {
          // Then check if it's in a valid state to be opened
          if ({LevelState.completed, LevelState.incomplete}
              .contains(levelBlocks[selectedLevelIndex].levelState)) {
            if (game.debugMode) {
              print('Opening level ${selectedLevelIndex + 1}');
            }
            // Open the level
            game.openLevel(levelNumber: selectedLevelIndex + 1);
            return true;
          }
        }
      }

      // Space for stoping the game
      if (event.logicalKey == LogicalKeyboardKey.space) {
        // Check if player is in level
        if (!game.isPlayerOnRoadmap) {
          PauseButton.toggleGamePause(game);
        }
      }
    }

    // Resets movement direction vector and pressed keys so they can be set again
    _keysPressed.clear();
    movement = Vector2.zero();

    _keysPressed.addAll(keysPressed);

    if (_keysPressed.contains(LogicalKeyboardKey.keyW)) {
      movement.y = -1;
      playerDirection = PlayerState.walkUp;
      current = PlayerState.walkUp;
    }
    if (_keysPressed.contains(LogicalKeyboardKey.keyS)) {
      movement.y = 1;
      playerDirection = PlayerState.walkDown;
      current = PlayerState.walkDown;
    }
    if (_keysPressed.contains(LogicalKeyboardKey.keyA)) {
      movement.x = -1;
      playerDirection = PlayerState.walkLeft;
      current = PlayerState.walkLeft;
    }
    if (_keysPressed.contains(LogicalKeyboardKey.keyD)) {
      movement.x = 1;
      playerDirection = PlayerState.walkRight;
      current = PlayerState.walkRight;
    }

    if (movement.length > 0) {
      movement = movement.normalized();
    }

    return true;
  }

  // ** Animations **
  // Based on the PlayerDirection set appropriate Player Idle State
  void _updatePlayerState() {
    if (movement.length == 0) {
      switch (playerDirection) {
        case PlayerState.walkUp:
          playerDirection = PlayerState.idleUp;
          current = PlayerState.idleUp;
          break;
        case PlayerState.walkDown:
          playerDirection = PlayerState.idleDown;
          current = PlayerState.idleDown;
          break;
        case PlayerState.walkLeft:
          playerDirection = PlayerState.idleLeft;
          current = PlayerState.idleLeft;
          break;
        case PlayerState.walkRight:
          playerDirection = PlayerState.idleRight;
          current = PlayerState.idleRight;
          break;
        default:
      }
    }
  }

  // Loads all animation
  void _loadAllAnimations() {
    idleUpAnimation = _spriteAnimation("idle_up", 5, idleStepTime);
    idleDownAnimation = _spriteAnimation("idle_down", 5, idleStepTime);
    idleLeftAnimation = _spriteAnimation("idle_left", 5, idleStepTime);
    idleRightAnimation = _spriteAnimation("idle_right", 5, idleStepTime);
    walkUpAnimation = _spriteAnimation("walk_up", 4, walkingStepTime);
    walkDownAnimation = _spriteAnimation("walk_down", 4, walkingStepTime);
    walkLeftAnimation = _spriteAnimation("walk_left", 4, walkingStepTime);
    walkRightAnimation = _spriteAnimation("walk_right", 4, walkingStepTime);

    animations = {
      PlayerState.idleDown: idleDownAnimation,
      PlayerState.idleLeft: idleLeftAnimation,
      PlayerState.idleRight: idleRightAnimation,
      PlayerState.idleUp: idleUpAnimation,
      PlayerState.walkDown: walkDownAnimation,
      PlayerState.walkLeft: walkLeftAnimation,
      PlayerState.walkRight: walkRightAnimation,
      PlayerState.walkUp: walkUpAnimation,
    };
    current = defaultState; // Default state
  }

  // Handles pictures repeating to create the animation
  SpriteAnimation _spriteAnimation(String state, int amount, double stepTime) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache("Main Characters/Bob/$state.png"),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
        loop: true,
      ),
    );
  }

  // ** Collision handling **
  // If player collides push him to the original place
  // X axis
  void _horizontalMovement(double dt) {
    if (movement.x != 0) {
      final horizontalMovement = Vector2(movement.x, 0);

      final originalX = position.x;
      position.x += horizontalMovement.x * speed * dt;
      if (checkForObstacleCollisions()) {
        position.x = originalX;
      }
    }
  }

  // Y axis
  void _verticalMovement(double dt) {
    if (movement.y != 0) {
      final verticalMovement = Vector2(0, movement.y);

      final originalY = position.y;
      position.y += verticalMovement.y * speed * dt;
      if (checkForObstacleCollisions()) {
        position.y = originalY;
      }
    }
  }

  // Activates function for each of the blocks to check the collisions with them
  bool checkForObstacleCollisions() {
    for (final block in collisionBlocks) {
      if (checkObstacleCollision(block)) {
        return true;
      }
    }
    return false;
  }

  // Checks collision with specific collision block
  bool checkObstacleCollision(CollisionBlock block) {
    final playerHitbox = Rect.fromLTWH(
      position.x + size.x / 4,
      position.y + size.y / 2,
      size.x / 2,
      size.y / 2,
    );
    final blockHitbox = Rect.fromLTWH(
      block.position.x,
      block.position.y,
      block.size.x,
      block.size.y,
    );
    // For debugging - print hitboxes
    // if (debugMode && playerHitbox.overlaps(blockHitbox)) {
    //   print('Collision detected: Player $playerHitbox with Block $blockHitbox');
    // }
    return playerHitbox.overlaps(blockHitbox);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is ToiletBlock) {
      for (final toilet in toiletBlocks) {
        // Makes that when player collides with another toilet block while still colliding with the old one, the old one is deselected.
        if (toilet.isSelected) {
          toilet.deselect();
        }
      }
      other.select();

      if (game.debugMode) {
        print(
          'Toilet block collision detected with \n X: ${other.position.x},\n Y: ${other.position.y}',
        );
      }
    }
    if (other is NpcBlock && !_penaltyCooldown) {
      // Apply time penalty
      game.applyTimePenalty(10);

      // Set cooldown to prevent continuous penalties
      _penaltyCooldown = true;

      // Reset cooldown after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        _penaltyCooldown = false;
      });

      if (game.debugMode) {
        print('Player touched NPC! -10 seconds penalty applied.');
      }
    }

    if (other is LevelBlock) {
      for (final level in levelBlocks) {
        if (level.isSelected) {
          level.select();
        }
      }
      other.select();
      print(
          'Player collided with level block at  ${other.position.x},\n Y: ${other.position.y}');
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // Deselects toiletblock and levelblock so it can be set when player collides with different one - this makes sure that only one is selected
    if (other is ToiletBlock) {
      other.deselect();
    }
    if (other is LevelBlock) {
      other.deselect();
    }
    super.onCollisionEnd(other);
  }

  // Player answer
  void answer(ToiletBlock selectedToilet) {
    if (selectedToilet.isCorrect) {
      game.timerActive = false; // Stop timer
      game.overlays.remove(PauseMenu.id);
      game.overlays.add(CorrectAnswerMenu.id);
      game.pauseEngine();
      if (game.debugMode) {
        print('Correct answer!');
      }
      // If player finishes his highest level, update the current level
      if (_userProvider.currentLevel == game.currentLevelIndex) {
        _userProvider.updateCurrentLevelNumber(_userProvider.currentLevel + 1);
      }
    } else {
      game.timerActive = false; // Stop timer
      game.overlays.remove(PauseMenu.id);
      game.overlays.add(WrongAnswerMenu.wrongAnswerId);
      game.pauseEngine();
      if (game.debugMode) {
        print('Wrong answer!');
      }
    }
  }

  // Reset player function to set it again when loading new level
  void reset() {
    // Clear lists
    collisionBlocks.clear();
    toiletBlocks.clear();
    levelBlocks.clear();
    npcBlocks.clear();

    // Reset position (will be set by new level)
    position = Vector2.zero();

    // Reset movement state
    movement = Vector2.zero();
    playerDirection = defaultState;
    current = defaultState;

    // Clear any active effects
    children.whereType<Effect>().forEach((effect) {
      effect.removeFromParent();
    });
  }

  // Update function
  @override
  void update(double dt) {
    // When player moves correct the movement with these functions
    if (movement.length > 0) {
      // Try horizontal movement first
      _horizontalMovement(dt);

      // After that try vertical
      _verticalMovement(dt);
    }

    // If not walking switch to appropriate idle state
    _updatePlayerState();

    super.update(dt);
  }
}
