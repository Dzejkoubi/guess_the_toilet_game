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
  double stepTime = 0.15;

  // Movement variables
  double speed = 70;
  Vector2 movement = Vector2.zero();
  final Set<LogicalKeyboardKey> _keysPressed = {};
  late PlayerState playerDirection;

  @override
  Future<void> onLoad() async {
    try {
      // Load all animation
      _loadAllAnimations();

      playerDirection = defaultState;
    } catch (e) {
      print('Error loading player assets: $e');
      rethrow;
    }
    return super.onLoad();
  }

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
    current = defaultState; // Default state
  }

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

  @override
  void update(double dt) {
    position = position + (movement * speed * dt);
    _updatePlayerState();

    super.update(dt);
  }
}
