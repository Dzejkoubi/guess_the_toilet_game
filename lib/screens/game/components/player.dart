import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_toilet/screens/game/components/collision_block.dart';
import 'package:guess_the_toilet/screens/game/components/toilet_block.dart';
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

  // Add reference to collision blocks
  List<CollisionBlock> collisionBlocks = [];

  // Add reference to toilet blocks
  List<ToiletBlock> toiletBlocks = [];

  // Track the toilet currently in interaction range
  ToiletBlock? interactiveToilet;

  // Key for interaction
  final interactionKey = LogicalKeyboardKey.space;

  Player({
    Vector2? position,
    this.defaultState = PlayerState.idleDown,
  }) : super(
          position: position,
          size: Vector2.all(32),
          anchor: Anchor.center, // Important for proper centering
        ) {
    debugMode = false;
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

  // Movement control
  Vector2 movementVector = Vector2.zero();
  late PlayerState currentDirection;
  final double moveSpeed = 70;

  // Track active keys
  final Set<LogicalKeyboardKey> _keysPressed = {};

  // Set player hitbox size
  final playerHitboxSize = Vector2(20, 32);

  @override
  Future<void> onLoad() async {
    try {
      // Set initial direction from default state
      currentDirection = defaultState;

      // Create animations from loaded images
      _loadAllAnimations();

      // Set the initial animation state
      current = defaultState;

      // Setup hitbox for collision detection - slightly smaller than the player sprite
    } catch (e) {
      print('Error loading player assets: $e');
      rethrow;
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // Split movement into horizontal and vertical components
    if (movementVector.length > 0) {
      // Try horizontal movement first
      _moveHorizontally(dt);

      // Then try vertical movement
      _moveVertically(dt);
    }

    // Check for toilets in range
    _checkToiletInteractions();

    // Update animation state
    _updatePlayerState();

    super.update(dt);
  }

  void _moveHorizontally(double dt) {
    if (movementVector.x != 0) {
      final horizontalMovement = Vector2(movementVector.x, 0);
      final originalX = position.x;

      position.x += horizontalMovement.x * moveSpeed * dt;

      if (checkCollisions()) {
        position.x = originalX;
      }
    }
  }

  void _moveVertically(double dt) {
    if (movementVector.y != 0) {
      final verticalMovement = Vector2(0, movementVector.y);
      final originalY = position.y;

      position.y += verticalMovement.y * moveSpeed * dt;

      if (checkCollisions()) {
        position.y = originalY;
      }
    }
  }

  // Check for collisions with obstacle blocks
  bool checkCollisions() {
    for (final block in collisionBlocks) {
      if (checkCollision(block)) {
        return true;
      }
    }
    return false;
  }

  // Check collision with a specific block
  bool checkCollision(CollisionBlock block) {
    // Calculate player hitbox rectangle centered on player position
    final playerHitbox = Rect.fromCenter(
      center: Offset(position.x, position.y),
      width: playerHitboxSize.x,
      height: playerHitboxSize.y,
    );

    // Calculate collision block rectangle
    final blockRect = Rect.fromLTWH(
      block.position.x,
      block.position.y,
      block.size.x,
      block.size.y,
    );

    // Debug visualization if needed
    // if (debugMode) {
    //   print("Player hitbox: $playerHitbox");
    //   print("Block rect: $blockRect");
    //   print("Collision: ${playerHitbox.overlaps(blockRect)}");
    // }

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

    // Normalize the movement vector if it's not zero(If walking up nad left at the same time, the vector would be 1,1 so it would move faster - this normalizes it to 1)
    if (movementVector.length > 0) {
      movementVector.normalize();
    }

    // Handle interaction key
    if (event is KeyDownEvent && event.logicalKey == interactionKey) {
      _interact();
    }

    return true; // Always return true to indicate we've handled the input
  }

  // Check if player is in range to interact with toilets
  void _checkToiletInteractions() {
    // Reset interactive toilet
    interactiveToilet = null;

    // Check all toilet blocks
    for (final toilet in toiletBlocks) {
      if (_isInInteractionRange(toilet)) {
        interactiveToilet = toilet;
        // Show visual indicator that toilet is in range
        toilet.select();
        break; // Only interact with one toilet at a time
      } else if (toilet.isSelected) {
        // Deselect if not in range anymore
        toilet.deselect();
      }
    }
  }

  // Check if player is in interaction range with a toilet
  bool _isInInteractionRange(ToiletBlock toilet) {
    // Calculate player hitbox rectangle centered on player position
    final playerHitbox = Rect.fromCenter(
      center: Offset(position.x, position.y),
      width: playerHitboxSize.x,
      height: playerHitboxSize.y,
    );

    // Calculate toilet block rectangle
    final toiletRect = Rect.fromLTWH(
      toilet.position.x,
      toilet.position.y,
      toilet.size.x,
      toilet.size.y,
    );

    return playerHitbox.overlaps(toiletRect);
  }

  // Interact with the toilet in range
  void _interact() {
    if (interactiveToilet != null) {
      // Toggle selection (this is just a demonstration - you can implement your game logic here)
      interactiveToilet!.toggleSelection();

      // Print toilet state for debugging
      print(
          'Interacted with toilet. Is correct? ${interactiveToilet!.isCorrect}');
    }
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

    // Set initial animation based on default state, but in reality does not change anything as it is set in _updatePlayerState
    current = defaultState;
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

  // Optionally add a visual representation of the hitbox for debugging
  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);

  //   if (debugMode) {
  //     // Draw the actual collision hitbox
  //     // Using Offset.zero since we're drawing in the component's local coordinate system
  //     // The anchor is already set to center in the constructor
  //     final rect = Rect.fromLTWH(
  //       Offset.zero.dx + playerHitboxSize.x / 3,
  //       Offset.zero.dy,
  //       playerHitboxSize.x,
  //       playerHitboxSize.y,
  //     );

  //     canvas.drawRect(
  //       rect,
  //       Paint()
  //         ..color = const Color.fromARGB(150, 255, 0, 0)
  //         ..style = PaintingStyle.stroke
  //         ..strokeWidth = 1,
  //     );
  //   }
  // }
}
