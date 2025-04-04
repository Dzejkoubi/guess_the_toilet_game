import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:guess_the_toilet/screens/game/components/player.dart';

class CollisionBlock extends PositionComponent {
  CollisionBlock({
    required super.position,
    required super.size,
    super.anchor = Anchor.topLeft,
  });
  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }
}
