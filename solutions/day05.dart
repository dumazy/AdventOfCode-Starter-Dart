import '../utils/index.dart';

class Day05 extends GenericDay {
  Day05() : super(5);

  @override
  (List<(int, int)>, List<List<int>>) parseInput() {
    final lines = input.getPerLine();
    final rules = <(int, int)>[];
    final updates = <List<int>>[];
    var readRules = true;
    for (final line in lines) {
      if (line.isEmpty) {
        readRules = false;
        continue;
      }
      if (readRules) {
        final [left, right] = line.split('|').map(int.parse).toList();
        rules.add((left, right));
      } else {
        final pages = line.split(',').map(int.parse).toList();
        updates.add(pages);
      }
    }
    return (rules, updates);
  }

  @override
  int solvePart1() {
    final (rules, updates) = parseInput();
    final correctUpdates = updates.where((update) {
      final resorted = update.sorted((a, b) => sortByRules(rules, a, b));
      return resorted.equals(update);
    });
    final middlePages = correctUpdates.map((update) {
      return update[update.length ~/ 2];
    });
    final sum = middlePages.reduce((a, b) => a + b);
    return sum;
  }

  @override
  int solvePart2() {
    final (rules, updates) = parseInput();
    final resortedUpdates = updates
        .map((update) {
          final resorted = update.sorted((a, b) => sortByRules(rules, a, b));
          if (resorted.equals(update)) {
            return null;
          }
          return resorted;
        })
        .nonNulls
        .toList();
    final middlePages = resortedUpdates.map((update) {
      return update[update.length ~/ 2];
    });
    final sum = middlePages.reduce((a, b) => a + b);
    return sum;
  }

  int sortByRules(List<(int, int)> rules, int a, int b) {
    for (final rule in rules) {
      final (left, right) = rule;
      if (a == left && b == right) {
        return -1;
      } else if (a == right && b == left) {
        return 1;
      }
    }
    return 0;
  }
}
