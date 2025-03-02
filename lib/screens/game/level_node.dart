import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:guess_the_toilet/theme/theme.dart';

class LevelNode extends PositionComponent {
  final int levelNumber; // level number
  bool isUnlocked; // is the level unlocked

  LevelNode({
    required this.levelNumber,
    required this.isUnlocked,
  }) {
    this.position = position;
    size = Vector2(50, 50);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final Paint paint = Paint()
      ..color = isUnlocked ? Color(0xFF00FF00) : Color(0xFF541616);
    canvas.drawCircle(
        Offset(size.x / 2, size.y / 2), // center
        size.x / 2, // radius
        paint);
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: levelNumber.toString(),
        style: AppTheme.lightTheme.textTheme.bodyLarge,
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        size.x / 2 - textPainter.width / 2,
        size.y / 2 - textPainter.height / 2,
      ),
    );
  }
}
