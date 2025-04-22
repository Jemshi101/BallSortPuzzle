import 'package:flutter/material.dart';
import '../models/ball.dart';

class BallWidget extends StatelessWidget {
  final Ball ball;
  final int tubeCapacity;

  const BallWidget({super.key, required this.ball, required this.tubeCapacity});

  double get _ballSize => 150.0 / tubeCapacity;

  Color _getColor(BallColor color) {
    switch (color) {
      case BallColor.red:
        return const Color(0xFFE57373);
      case BallColor.blue:
        return const Color(0xFF64B5F6);
      case BallColor.green:
        return const Color(0xFF81C784);
      case BallColor.yellow:
        return const Color(0xFFFFF176);
      case BallColor.orange:
        return const Color(0xFFFFB74D);
      case BallColor.purple:
        return const Color(0xFF9575CD);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _ballSize,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: _getColor(ball.color),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
