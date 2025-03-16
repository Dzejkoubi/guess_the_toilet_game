import 'dart:async';

import 'package:flame/components.dart';

class Player extends SpriteAnimationGroupComponent {
  Player({
    position,
  }) : super(
          position: position,
          size: Vector2.all(32),
        ) {
    debugMode = true;
  }

  @override
  FutureOr<void> onLoad() {
    return super.onLoad();
  }
}
