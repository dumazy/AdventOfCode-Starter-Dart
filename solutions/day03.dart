import '../utils/index.dart';

class Day03 extends GenericDay {
  Day03() : super(3);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final regex = RegExp(r'mul\(\d+,\d+\)');
    var sum = 0;
    for (final line in parseInput()) {
      final matches = regex.allMatches(line);
      for (final match in matches) {
        final [a, b] = matchValues(match.group(0)!);
        sum += a * b;
      }
    }
    return sum;
  }

  @override
  int solvePart2() {
    final regex = RegExp(r"mul\(\d+,\d+\)|do\(\)|don\'t\(\)");
    var sum = 0;
    var enabled = true;
    for (final line in parseInput()) {
      final matches = regex.allMatches(line);
      for (final match in matches) {
        final matching = match.group(0);
        switch (matching) {
          case 'do()':
            enabled = true;
          case "don't()":
            enabled = false;
          default:
            if (enabled) {
              final [a, b] = matchValues(matching!);
              sum += a * b;
            }
        }
      }
    }
    return sum;
  }

  List<int> matchValues(String line) {
    return RegExp(r'\d+')
        .allMatches(line)
        .map((e) => int.parse(e.group(0)!))
        .toList();
  }
}
