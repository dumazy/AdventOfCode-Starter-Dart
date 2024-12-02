import '../utils/index.dart';

class Day01 extends GenericDay {
  Day01() : super(1);

  @override
  (List<int>, List<int>) parseInput() {
    final left = <int>[];
    final right = <int>[];
    final lines = input.getPerLine();
    for (final line in lines) {
      final parts = line.split('  ');
      left.add(int.parse(parts[0]));
      right.add(int.parse(parts[1]));
    }
    return (left, right);
  }

  @override
  int solvePart1() {
    final (left, right) = parseInput();
    final leftSorted = left.sorted((a, b) => a.compareTo(b));
    final rightSorted = right.sorted((a, b) => a.compareTo(b));
    var distance = 0;
    for (var i = 0; i < leftSorted.length; i++) {
      distance += (leftSorted[i] - rightSorted[i]).abs();
    }
    return distance;
  }

  @override
  int solvePart2() {
    final (left, right) = parseInput();
    return left.fold(0, (prev, element) {
      return prev + (element * right.where((r) => r == element).length);
    });
  }
}
