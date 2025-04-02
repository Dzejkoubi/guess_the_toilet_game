import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum LevelState {
  completed,
  incomplete,
  locked,
}

class LevelBlock extends PositionComponent with HasGameRef {
  final LevelState levelState;
  late SpriteComponent background;
  bool _isSelected = false;

  LevelBlock({
    required super.position,
    this.levelState = LevelState.locked,
    this.onSelectionChanged,
  }) : super(
          size: Vector2.all(32),
          anchor: Anchor.topLeft,
        ) {
    debugMode = true;
  }

  @override
  FutureOr<void> onLoad() async {
    // Wait for the levelstate to be set and then set the proper background
    final sprite = await _getSpriteForLevelState();
    background = SpriteComponent(
      sprite: sprite,
      size: size,
      anchor: Anchor.topLeft,
    );
    add(background);

    final hitbox = RectangleHitbox(
      position: Vector2.zero(),
      size: Vector2(
        size.x,
        size.y,
      ),
    );
    add(hitbox);

    return super.onLoad();
  }

  final void Function(LevelBlock levelState, bool isSelected)?
      onSelectionChanged;

  bool get isSelected => _isSelected;

  // Select the toilet before answering
  void select() {
    if (!_isSelected) {
      _isSelected = true;
      onSelectionChanged?.call(this, true);
    }
  }

  // Deselect the before answering
  void deselect() {
    if (_isSelected) {
      _isSelected = false;
      onSelectionChanged?.call(this, false);
    }
  }

  // Helper method to get the sprite based on the level state
  Future<Sprite> _getSpriteForLevelState() async {
    switch (levelState) {
      case LevelState.completed:
        return Sprite(
            await gameRef.images.load('Menu/roadmap_button_done.png'));
      case LevelState.incomplete:
        return Sprite(
            await gameRef.images.load('Menu/roadmap_button_play.png'));
      case LevelState.locked:
      default:
        return Sprite(
            await gameRef.images.load('Menu/roadmap_button_locked.png'));
    }
  }
}
