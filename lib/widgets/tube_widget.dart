import 'package:ball_sort_puzzle/models/tube.dart';
import 'package:ball_sort_puzzle/widgets/ball_widget.dart';
import 'package:flutter/material.dart';

class TubeWidget extends StatelessWidget {
  final Tube tube;
  final bool isSelected;

  const TubeWidget({
    super.key,
    required this.tube,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 200,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(
          tube.capacity,
          (index) {
            int ballIndex = tube.balls.length - tube.capacity + index;
            return  ballIndex >= 0 ?
              BallWidget(
                ball: tube.balls[ballIndex],
                tubeCapacity: tube.capacity,
              ) : const SizedBox(height: 24);
          },
        ),
      ),
    );
  }
}
