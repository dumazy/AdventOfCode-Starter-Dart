import '../utils/index.dart';

final digitRegExp = RegExp('[0-9]');
final digitAndWordRegExp =
    RegExp('[0-9]|one|two|three|four|five|six|seven|eight|nine');
final suffixDigitAndWord =
    RegExp('[0-9]|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin');

class Day01 extends GenericDay {
  Day01() : super(1);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  List<int> _extractFirstAndLast(String line, {bool matchWords = false}) {
    final numbers = [
      firstNumber(line, matchWords),
      lastNumber(line, matchWords),
    ];
    assert(numbers.length == 2, 'Invalid numbers length');
    return numbers;
  }

  int firstNumber(String line, bool matchWords) {
    final regExp = matchWords ? digitAndWordRegExp : digitRegExp;
    final firstMatch = regExp.allMatches(line).first;
    return parseMatch(firstMatch);
  }

  int lastNumber(String line, bool matchWords) {
    final regExp = matchWords ? suffixDigitAndWord : digitRegExp;
    final reversedLine = line.split('').reversed.join();
    final lastMatch = regExp.allMatches(reversedLine).first;
    return parseMatch(lastMatch);
  }

  int parseMatch(RegExpMatch match) {
    final value = match.group(0)!;
    return switch (value) {
      'one' => 1,
      'two' => 2,
      'three' => 3,
      'four' => 4,
      'five' => 5,
      'six' => 6,
      'seven' => 7,
      'eight' => 8,
      'nine' => 9,
      'eno' => 1,
      'owt' => 2,
      'eerht' => 3,
      'ruof' => 4,
      'evif' => 5,
      'xis' => 6,
      'neves' => 7,
      'thgie' => 8,
      'enin' => 9,
      _ => int.parse(value),
    };
  }

  @override
  int solvePart1() {
    final input = parseInput();
    return input
        .map(_extractFirstAndLast)
        .map((element) => int.parse('${element.first}${element.last}'))
        .reduce((a, b) => a + b);
  }

  @override
  int solvePart2() {
    final input = parseInput();
    return input
        .map((line) => _extractFirstAndLast(line, matchWords: true))
        .map((element) => int.parse('${element.first}${element.last}'))
        .reduce((a, b) => a + b);
  }
}
