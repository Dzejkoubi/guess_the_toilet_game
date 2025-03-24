import 'package:flame/components.dart';
import 'package:flutter/material.dart';

// Enum to represent answer state
enum ToiletAnswerState {
  unanswered,
  correct,
  wrong,
}

class ToiletBlock extends PositionComponent {
  // Track if this toilet block is currently selected
  bool _isSelected = false;
  // Track answer state
  ToiletAnswerState _answerState = ToiletAnswerState.unanswered;

  // When selection changes
  final void Function(ToiletBlock toilet, bool isSelected)? onSelectionChanged;

  ToiletBlock({
    required super.position,
    required super.size,
    super.anchor = Anchor.topLeft,
    this.onSelectionChanged,
  }) {
    debugMode = false;
  }

  // Getters
  bool get isSelected => _isSelected;
  ToiletAnswerState get answerState => _answerState;
  bool get isCorrect => _answerState == ToiletAnswerState.correct;
  bool get isWrong => _answerState == ToiletAnswerState.wrong;

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

  // Toggle selection state
  void toggleSelection() {
    _isSelected = !_isSelected;
    onSelectionChanged?.call(this, _isSelected);
  }

  // In the level.dart file - if toilet is found as correct set _answerState as correct - not an answer of player but value that will be evaluated as the user answers
  void markCorrect() {
    _answerState = ToiletAnswerState.correct;
  }

  // -||- but wrong == correct
  void markWrong() {
    _answerState = ToiletAnswerState.wrong;
  }

  @override
  void render(Canvas canvas) {
    // When debugging see which toilets are correct and which ones wrong
    if (debugMode) {
      final paint = Paint()..style = PaintingStyle.fill;
      if (answerState == ToiletAnswerState.correct) {
        paint.color = Colors.green.withOpacity(0.5);
      } else if (answerState == ToiletAnswerState.wrong) {
        paint.color = Colors.red.withOpacity(0.5);
      } else {
        paint.color = Colors.grey.withOpacity(0.5);
      }
      canvas.drawRect(
        Rect.fromLTWH(0, 0, width, height),
        paint,
      );
    }
    // Making the selection visual styling
    if (_isSelected) {
      final paint = Paint()..style = PaintingStyle.fill;
      paint.color = Colors.blue.withOpacity(0.5);
      canvas.drawRect(
        Rect.fromLTWH(0, 0, width, height),
        paint,
      );
    }

    // Draw border for selected toilets
    if (_isSelected) {
      final borderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Colors.white;

      canvas.drawRect(
        Rect.fromLTWH(0, 0, width, height),
        borderPaint,
      );
    }

    super.render(canvas);
  }
}
