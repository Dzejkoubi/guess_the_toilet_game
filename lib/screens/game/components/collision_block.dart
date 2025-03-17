import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  CollisionBlock({
    required super.position,
    required super.size,
    super.angle = 0,
    super.anchor = Anchor.topLeft,
  }) {
    // Set to true to see collision blocks when debugging
    debugMode = true;
  }
}
