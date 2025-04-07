import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

// Enum to represent answer state
enum NpcType {
  slim,
  wide,
}

class NpcBlock extends PositionComponent with CollisionCallbacks {
  // Track answer state
  final NpcType npcType;
  bool hasCollided = false;

  NpcBlock({
    required super.position,
    required super.size,
    super.anchor = Anchor.topLeft,
    this.npcType = NpcType.slim,
  });

  @override
  FutureOr<void> onLoad() {
    if (npcType == NpcType.slim) {
      final hitbox = RectangleHitbox(
        position: Vector2(
          size.x * 5 / 16, // Offset by 1/4 width to center
          0, // Offset by 1/4 height to center
        ),
        size: Vector2(
          size.x * 6 / 16,
          size.y,
        ),
      );
      add(hitbox);
    } else {
      final hitbox = RectangleHitbox(
        position: Vector2(
          size.x * 3 / 16, // Offset by 1/8 width to center
          0, // Offset by 1/8 height to center
        ),
        size: Vector2(
          size.x * 10 / 16,
          size.y,
        ),
      );
      add(hitbox);
    }

    return super.onLoad();
  }
}
