import 'dart:math';

import 'package:equatable/equatable.dart';

import '../utils/index.dart';
import '../utils/map_util.dart';

class Day04 extends GenericDay {
  Day04() : super(4);

  @override
  Map<Point, String> parseInput() {
    final lines = input.getPerLine();
    final width = lines[0].length;
    final height = lines.length;
    final map = <Point, String>{};
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        map[Point(x, y)] = lines[y][x];
      }
    }
    return map;
  }

  @override
  int solvePart1() {
    final Set<Word> words = {};
    for (final entry in parseInput().entries) {
      final point = entry.key;
      final char = entry.value;
      if (char == 'X') {
        for (final direction in Direction.values) {
          final word = _findWord(point, direction, parseInput(), 'XMAS');
          if (word != null) {
            words.add(word);
          }
        }
      }
    }
    return words.length;
  }

  @override
  int solvePart2() {
    final Set<Word> words = {};
    for (final entry in parseInput().entries) {
      final point = entry.key;
      final char = entry.value;
      if (char == 'M') {
        for (final direction in [
          Direction.northEast,
          Direction.southWest,
          Direction.southEast,
          Direction.northWest
        ]) {
          final word = _findWord(point, direction, parseInput(), 'MAS');
          if (word != null) {
            words.add(word);
          }
        }
      }
    }
    final wordsPerMiddleLetter = <Point, List<Word>>{};
    for (final word in words) {
      final middleLetter = movePoint(word.position, word.direction);
      wordsPerMiddleLetter.putIfAbsent(middleLetter, () => []);
      wordsPerMiddleLetter[middleLetter]!.add(word);
    }
    final entries = wordsPerMiddleLetter.entries.where((entry) {
      return entry.value.length >= 2;
    });

    return entries.length;
  }

  Word? _findWord(
    Point point,
    Direction direction,
    Map<Point, String> map,
    String match,
  ) {
    var word = '';
    var currentPoint = point;
    while (map.containsKey(currentPoint)) {
      final nextChar = match[word.length];
      final char = map[currentPoint];
      if (char == nextChar) {
        word += nextChar;
      } else {
        break;
      }
      if (word == match) {
        return Word(word, point, direction);
      }
      currentPoint = movePoint(currentPoint, direction);
    }
    return null;
  }
}

class Word extends Equatable {
  const Word(this.word, this.position, this.direction);

  final String word;
  final Point position;
  final Direction direction;

  @override
  List<Object?> get props => [word, position, direction];
}

