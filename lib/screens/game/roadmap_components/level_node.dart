import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LevelNode extends CircleComponent {
  LevelNode({
    required super.position,
    required double radius,
    Color color = Colors.white,
  }) : super(
          anchor: Anchor.center,
          radius: radius,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill,
        );
}
