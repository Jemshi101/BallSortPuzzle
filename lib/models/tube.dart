import 'ball.dart';

class Tube {
  final int capacity;
  final List<Ball> balls;

  Tube({required this.capacity, List<Ball>? balls}) : balls = balls ?? [];

  bool canAdd(Ball ball) {
    return balls.length < capacity &&
        (balls.isEmpty || balls.first.color == ball.color);
  }

  bool get isEmpty => balls.isEmpty;

  bool get isComplete {
    if (balls.isEmpty) return false;
    return balls.length == capacity &&
        balls.every((b) => b.color == balls[0].color);
  }

  Ball? popBall() => balls.isNotEmpty ? balls.removeAt(0) : null;

  bool pushBall(Ball ball) {
    if (canAdd(ball)) {
      balls.insert(0, ball);
      return true;
    }
    return false;
  }
}
