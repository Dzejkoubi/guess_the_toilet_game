import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_toilet/screens/game/components/blocks/collision_block.dart';
import 'package:guess_the_toilet/screens/guess_the_toilet_game/guess_the_toilet.dart';

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
    with HasGameRef<GuessTheToilet>, KeyboardHandler {
  final PlayerState defaultState;
  Player({
    Vector2? position,
    Vector2? size,
    this.defaultState = PlayerState.idleDown,
  }) : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        ) {
    debugMode:
    false;
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
  double stepTime = 0.15; // Time between changing the picture in animaiton

  // Movement control
  Vector2 movementVector = Vector2.zero();
  late PlayerState currentDirection;
  final double moveSpeed = 70;
  final Set<LogicalKeyboardKey> _keysPressed = {}; // Track active keys

  @override
  FutureOr<void> onLoad() {
    try {
      _loadAllAnimations(); // Load all animations

      currentDirection =
          defaultState; // Set initial direction  from default state

      current = defaultState; // Set initial animation state
      add(
        RectangleHitbox(
          size: Vector2(size.x, size.y),
          anchor: anchor,
          position: position,
        ),
      );
    } catch (e) {
      print('Error loading player assets: $e');
      rethrow;
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // Update player state when stops moving
    _updatePlayerStateWhenStopsWalking();
    super.update(dt);
  }

  bool checkCollision(CollisionBlock block) {
    final playerHitbox = Rect.fromLTWH(x, y, width, height);
    final blockRect = Rect.fromLTWH(
      block.position.x,
      block.position.y,
      block.size.x,
      block.size.y,
    );
    print(playerHitbox.overlaps(blockRect).toString());
    return playerHitbox.overlaps(blockRect);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Store currently pressed keys
    _keysPressed.clear();
    _keysPressed.addAll(keysPressed);

    // Reset movement vector
    movementVector = Vector2.zero();

    // Apply movement based on keys pressed
    if (_keysPressed.contains(LogicalKeyboardKey.keyW) ||
        _keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      movementVector.y = -1;
      currentDirection = PlayerState.walkUp;
    } else if (_keysPressed.contains(LogicalKeyboardKey.keyS) ||
        _keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      movementVector.y = 1;
      currentDirection = PlayerState.walkDown;
    }

    if (_keysPressed.contains(LogicalKeyboardKey.keyA) ||
        _keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      movementVector.x = -1;
      currentDirection = PlayerState.walkLeft;
    } else if (_keysPressed.contains(LogicalKeyboardKey.keyD) ||
        _keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      movementVector.x = 1;
      currentDirection = PlayerState.walkRight;
    }

    // Normalize the movement vector when moving diagonally
    if (movementVector.length > 0) {
      movementVector.normalize();
    }

    return true; // Always return true to indicate we've handled the input
  }

  // If player stops moving show the direction animation
  void _updatePlayerStateWhenStopsWalking() {
    if (movementVector.length > 0) {
      current = currentDirection;
    } else {
      // If not moving, switch to idle animation based on last direction
      switch (currentDirection) {
        case PlayerState.walkDown:
          current = PlayerState.idleDown;
          break;
        case PlayerState.walkUp:
          current = PlayerState.idleUp;
          break;
        case PlayerState.walkLeft:
          current = PlayerState.idleLeft;
          break;
        case PlayerState.walkRight:
          current = PlayerState.idleRight;
          break;
        default:
      }
    }
  }

  // Load all animation
  void _loadAllAnimations() {
    idleUpAnimation = _spriteAnimation("idle_up", 5);
    idleDownAnimation = _spriteAnimation("idle_down", 5);
    idleLeftAnimation = _spriteAnimation("idle_left", 5);
    idleRightAnimation = _spriteAnimation("idle_right", 5);
    walkUpAnimation = _spriteAnimation("walk_up", 4);
    walkDownAnimation = _spriteAnimation("walk_down", 4);
    walkLeftAnimation = _spriteAnimation("walk_left", 4);
    walkRightAnimation = _spriteAnimation("walk_right", 4);

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
  }

  // Updated to use consistent paths that match the _loadImages method
  SpriteAnimation _spriteAnimation(String state, int amount) {
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
}
