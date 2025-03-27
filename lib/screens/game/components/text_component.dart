import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GameText extends TextComponent {
  GameText(
    String text, {
    Vector2? position,
    double? fontSize,
    Color? textColor = Colors.black,
    TextAlignVertical? verticalAlign,
    TextAlign? textAlign,
    Anchor? anchor,
  }) : super(
          text: text,
          position: position,
          anchor: anchor ?? Anchor.topLeft,
          textRenderer: TextPaint(
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          ),
        );
}
