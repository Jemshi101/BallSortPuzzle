import 'package:ball_sort_puzzle/models/ball.dart';
import 'package:ball_sort_puzzle/models/tube.dart';
import 'package:ball_sort_puzzle/widgets/tube_widget.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int tubeCapacity = 4;
  List<Tube> tubes = [];
  int? selectedTubeIndex;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    final colors = BallColor.values;
    final ballsPerColor = tubeCapacity;
    final allBalls = [
      for (var color in colors)
        for (int i = 0; i < ballsPerColor; i++) Ball(color),
    ]..shuffle();

    final tubeCount = colors.length + 2;
    tubes = List.generate(tubeCount, (_) => Tube(capacity: tubeCapacity));

    int ballIndex = 0;
    for (int i = 0; i < colors.length; i++) {
      for (int j = 0; j < tubeCapacity; j++) {
        tubes[i].balls.add(allBalls[ballIndex++]);
      }
    }
    setState(() {});
  }

  void _handleTubeTap(int index) {
    setState(() {
      if (selectedTubeIndex == null) {
        if (tubes[index].isEmpty) return;
        selectedTubeIndex = index;
      } else {
        var from = tubes[selectedTubeIndex!];
        var to = tubes[index];
        if (from.balls.isNotEmpty && to.canAdd(from.balls.first)) {
          final ball = from.popBall();
          if (ball != null) {
            to.pushBall(ball);
          }
        }

        selectedTubeIndex = null;
        if (_checkWinCondition()) {
          _showWinDialog();
        }
      }
    });
  }

  bool _checkWinCondition() {
    return tubes
        .where((tube) => tube.balls.isNotEmpty)
        .every((tube) => tube.isComplete);
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('You Win! 🎉'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _initializeGame();
                },
                child: const Text('Restart'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ball Sort Puzzle')),
      body: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: List.generate(
            tubes.length,
            (index) => GestureDetector(
              onTap: () => _handleTubeTap(index),
              child: TubeWidget(
                tube: tubes[index],
                isSelected: selectedTubeIndex == index,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
