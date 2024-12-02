import '../utils/index.dart';

class Day02 extends GenericDay {
  Day02() : super(2);

  @override
  List<List<int>> parseInput() {
    return input.getPerLine().map((line) {
      return line.split(' ').map(int.parse).toList();
    }).toList();
  }

  @override
  int solvePart1() {
    final safeReports = parseInput().where((report) {
      try {
        safeDirectionOrThrowIndex(report);
        minorChangeOrThrowIndex(report);
        return true;
      } catch (e) {
        return false;
      }
    }).toList();
    return safeReports.length;
  }

  @override
  int solvePart2() {
    final safeReports = parseInput().where((report) {
      try {
        safeDirectionOrThrowIndex(report);
        minorChangeOrThrowIndex(report);
        return true;
      } on int catch (index) {
        if (tryWithout(report, index - 1) ||
            tryWithout(report, index) ||
            tryWithout(report, index + 1)) {
          return true;
        }
        return false;
      }
    }).toList();
    return safeReports.length;
  }

  bool tryWithout(List<int> line, int index) {
    try {
      final copy = List<int>.from(line)..removeAt(index);
      safeDirectionOrThrowIndex(copy);
      minorChangeOrThrowIndex(copy);
      return true;
    } on int {
      return false;
    } catch (e) {
      return false;
    }
  }

  void safeDirectionOrThrowIndex(List<int> line) {
    final increasing = line[0] < line[1];
    for (var i = 1; i < line.length - 1; i++) {
      final current = line[i];
      final next = line[i + 1];
      final nextIncreasing = current < next;
      if (increasing != nextIncreasing) {
        throw i;
      }
    }
  }

  void minorChangeOrThrowIndex(List<int> line) {
    for (var i = 0; i < line.length - 1; i++) {
      final current = line[i];
      final next = line[i + 1];
      final difference = (current - next).abs();
      if (difference < 1 || difference > 3) {
        throw i;
      }
    }
  }
}
