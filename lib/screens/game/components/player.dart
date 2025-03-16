import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
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
    with HasGameRef<GuessTheToilet>, KeyboardHandler {
  Player({
    position,
    PlayerState defaultState = PlayerState.idleUp,
  }) : super(
          position: position,
          size: Vector2.all(32),
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
  double stepTime = 0.15;
  double moveSpeed = 100;

  // Movement control
  Vector2 movementVector = Vector2.zero();
  PlayerState currentDirection = PlayerState.idleUp;

  @override
  Future<void> onLoad() async {
    try {
      // Then create animations from loaded images
      _loadAllAnimations();
    } catch (e) {
      print('Error loading player assets: $e');
      rethrow;
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // Update the player's position based on movement vector
    position += movementVector * moveSpeed * dt;

    // Update the player's animation state
    _updatePlayerState();

    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Reset movement vector
    movementVector = Vector2.zero();

    // Apply movement based on keys pressed
    if (keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      movementVector.y = -1;
      currentDirection = PlayerState.walkUp;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      movementVector.y = 1;
      currentDirection = PlayerState.walkDown;
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      movementVector.x = -1;
      currentDirection = PlayerState.walkLeft;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      movementVector.x = 1;
      currentDirection = PlayerState.walkRight;
    }

    // Normalize the movement vector if it's not zero
    if (movementVector.length > 0) {
      movementVector.normalize();
    }

    return true;
  }

  void _updatePlayerState() {
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
          current = PlayerState
              .idleLeft; // Default to idle left if no direction is set -- this should never happen but is RIGHT NOW ACTIVE BUG
      }
    }
  }

  void _loadAllAnimations() {
    int numberOfFrames = 5;
    idleUpAnimation = _spriteAnimation("idle_up", numberOfFrames);
    idleDownAnimation = _spriteAnimation("idle_down", numberOfFrames);
    idleLeftAnimation = _spriteAnimation("idle_left", numberOfFrames);
    idleRightAnimation = _spriteAnimation("idle_right", numberOfFrames);
    walkUpAnimation = _spriteAnimation("walk_up", numberOfFrames);
    walkDownAnimation = _spriteAnimation("walk_down", numberOfFrames);
    walkLeftAnimation = _spriteAnimation("walk_left", numberOfFrames);
    walkRightAnimation = _spriteAnimation("walk_right", numberOfFrames);

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

    current = PlayerState.idleUp;
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
