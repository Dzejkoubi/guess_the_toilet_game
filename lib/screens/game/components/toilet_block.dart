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

  // Optional callback for when selection changes
  final void Function(ToiletBlock toilet, bool isSelected)? onSelectionChanged;

  // Store any identifier or data about this toilet option
  final String? toiletId;
  final dynamic toiletData;

  ToiletBlock({
    required super.position,
    required super.size,
    super.angle = 0,
    super.anchor = Anchor.topLeft,
    this.onSelectionChanged,
    this.toiletId,
    this.toiletData,
  }) {
    // Enable debug mode for development
    debugMode = true;
  }

  // Getters
  bool get isSelected => _isSelected;
  ToiletAnswerState get answerState => _answerState;
  bool get isCorrect => _answerState == ToiletAnswerState.correct;
  bool get isWrong => _answerState == ToiletAnswerState.wrong;

  // Method to select this toilet option
  void select() {
    if (!_isSelected) {
      _isSelected = true;
      onSelectionChanged?.call(this, true);
    }
  }

  // Method to deselect this toilet option
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

  // Set answer state
  void setAnswerState(ToiletAnswerState state) {
    _answerState = state;
  }

  // Mark as correct answer
  void markCorrect() {
    _answerState = ToiletAnswerState.correct;
  }

  // Mark as wrong answer
  void markWrong() {
    _answerState = ToiletAnswerState.wrong;
  }

  // Reset to unanswered state
  void resetAnswerState() {
    _answerState = ToiletAnswerState.unanswered;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (debugMode) {
      final paint = Paint()..style = PaintingStyle.fill;

      // Determine fill color based on selection and answer state
      if (_answerState == ToiletAnswerState.correct) {
        paint.color = Colors.green.withOpacity(0.5);
      } else if (_answerState == ToiletAnswerState.wrong) {
        paint.color = Colors.red.withOpacity(0.5);
      } else {
        paint.color = _isSelected
            ? Colors.blue.withOpacity(0.5)
            : Colors.grey.withOpacity(0.3);
      }

      canvas.drawRect(
        Rect.fromLTWH(0, 0, width, height),
        paint,
      );

      // Add border
      final borderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      // Determine border color
      if (_answerState == ToiletAnswerState.correct) {
        borderPaint.color = Colors.green;
      } else if (_answerState == ToiletAnswerState.wrong) {
        borderPaint.color = Colors.red;
      } else {
        borderPaint.color = _isSelected ? Colors.blue : Colors.grey;
      }

      canvas.drawRect(
        Rect.fromLTWH(0, 0, width, height),
        borderPaint,
      );
    }
  }
}
