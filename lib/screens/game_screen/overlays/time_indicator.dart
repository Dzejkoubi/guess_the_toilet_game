import 'package:flutter/material.dart';
import 'package:guess_the_toilet/screens/game/guess_the_toilet.dart';

class TimeIndicator extends StatefulWidget {
  static const String id = 'TimeIndicator';

  final int timeLimit;
  final double timeRemaining;
  final GuessTheToilet gameRef;

  const TimeIndicator({
    Key? key,
    required this.timeLimit,
    required this.timeRemaining,
    required this.gameRef,
  }) : super(key: key);

  @override
  State<TimeIndicator> createState() => _TimeIndicatorState();
}

class _TimeIndicatorState extends State<TimeIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), // Animation smoothness
    );
    _controller.value = widget.timeRemaining / widget.timeLimit;
  }

  @override
  void didUpdateWidget(TimeIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Animate to the new value smoothly
    _controller.animateTo(
      widget.timeRemaining / widget.timeLimit,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Don't show for levels with no time limit
    if (widget.timeLimit <= 0) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 10,
      left: 10,
      right: 60, // Leave space for pause button on right
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  // Transparent background
                  Container(
                    width: double.infinity,
                    color: Colors.transparent,
                  ),
                  // Colored progress bar
                  FractionallySizedBox(
                    widthFactor: _controller.value,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: getColorsByTimePercentage(_controller.value),
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                  // Time text overlay
                  Center(
                    child: Text(
                      '${widget.timeRemaining.ceil()} s',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                          fontFamily: 'dpcomic'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Change color based on time remaining
  List<Color> getColorsByTimePercentage(double percentage) {
    if (percentage > 0.6) {
      return [Colors.green.shade300, Colors.green];
    } else if (percentage > 0.3) {
      return [Colors.orange.shade300, Colors.orange];
    } else {
      return [Colors.red.shade300, Colors.red];
    }
  }
}
