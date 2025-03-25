import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_toilet/screens/game/components/blocks/collision_block.dart';
import 'package:guess_the_toilet/screens/game/components/blocks/toilet_block.dart';
import 'package:guess_the_toilet/screens/game/components/level.dart';
import 'package:guess_the_toilet/screens/game/guess_the_toilet.dart';

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
        ) {
    debugMode = true;
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
  List<CollisionBlock> collisionBlocks = [];
  List<ToiletBlock> get getCollisionBlock => toiletBlocks;

  // Toilet blocks for answering
  final List<ToiletBlock> toiletBlocks = [];
  List<ToiletBlock> get getToiletBlocks => toiletBlocks;
  late ToiletBlock _activeToilet;

  // Pressed keys
  final Set<LogicalKeyboardKey> _keysPressed = {};

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

    final playerHitbox = RectangleHitbox(
      position: Vector2(0, size.y * 0.5), // Bottom half of player
      size: Vector2(size.x, size.y * 0.5), // Half of player height
    );
    add(playerHitbox);

    return super.onLoad();
  }

  // Handles key events like: walking
  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
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

  // ** If player collides push him to the original place **
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

  // Checks collision with specific block
  bool checkObstacleCollision(CollisionBlock block) {
    final playerHitbox = Rect.fromCenter(
      center: Offset(position.x + size.x / 2,
          position.y + size.y * 0.75), // Center at bottom half of player
      width: size.x / 2, // Half width
      height: size.y / 2, // Half height
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
        if (toilet.isSelected) {
          toilet.deselect();
        }
      }
      other.select();
      if (debugMode) {
        print(
          'Toilet block collision detected with \n X: ${other.position.x},\n Y: ${other.position.y}',
        );
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is ToiletBlock) {
      other.deselect();
    }
    super.onCollisionEnd(other);
  }

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
