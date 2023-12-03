import '../utils/index.dart';

/// numbers and anything other than a dot (.)
final engineMapRegExp = RegExp('([0-9]+|[^.])');
final numberRegExp = RegExp('[0-9]+');

class Day03 extends GenericDay {
  Day03() : super(3);

  List<NumberField> numbers = [];
  List<SymbolField> symbols = [];

  @override
  void parseInput() {
    numbers.clear();
    symbols.clear();
    final indexedLines = input.getPerLine().indexed;
    for (final (y, line) in indexedLines) {
      final matches = engineMapRegExp.allMatches(line);
      for (final match in matches) {
        final x = match.start;
        final value = match.group(0)!;
        final isNumber = numberRegExp.hasMatch(value);
        if (!isNumber) {
          final field = SymbolField(x, y, value);
          symbols.add(field);
          continue;
        }
        final number = int.parse(value);
        final field = NumberField(x, y, number);
        numbers.add(field);
      }
    }
  }

  @override
  int solvePart1() {
    parseInput();
    final engineParts = numbers.where((numberField) {
      final adjacentFields = numberField.adjecentFields;
      return adjacentFields.any((adjacentField) {
        return symbols.any((symbolField) {
          return symbolField.x == adjacentField.$1 &&
              symbolField.y == adjacentField.$2;
        });
      });
    });
    final engineNumbers = engineParts.map((e) => e.value);
    return engineNumbers.reduce((a, b) => a + b);
  }

  @override
  int solvePart2() {
    parseInput();
    var gearRatio = 0;
    final gears = symbols.where((symbolField) => symbolField.value == '*');
    for (final gear in gears) {
      final adjacentNumbers = numbers.where((number) {
        return number.adjecentFields.any((adjacentField) {
          return adjacentField.$1 == gear.x && adjacentField.$2 == gear.y;
        });
      });
      if (adjacentNumbers.length == 2) {
        gearRatio += adjacentNumbers.first.value * adjacentNumbers.last.value;
      }
    }

    return gearRatio;
  }
}

class Field<T> {
  Field(this.x, this.y, this.value);

  final int x;
  final int y;
  final T value;

  int get width => 1;
  int get height => 1;

  @override
  String toString() {
    return 'Field<$T>(x: $x, y: $y, value: $value)';
  }
}

class NumberField extends Field<int> {
  NumberField(super.x, super.y, super.value);

  @override
  int get width => value.toString().length;

  List<(int, int)> get adjecentFields => [
        (x - 1, y - height),
        (x - 1, y),
        (x - 1, y + height),
        ...Iterable.generate(width, (i) => (x + i, y - height)),
        ...Iterable.generate(width, (i) => (x + i, y + height)),
        (x + width, y - height),
        (x + width, y),
        (x + width, y + height),
      ];

  @override
  String toString() {
    return 'NumberField(x: $x, y: $y, number: $value)';
  }
}

class SymbolField extends Field<String> {
  SymbolField(super.x, super.y, super.value);

  @override
  int get width => value.length;

  @override
  String toString() {
    return 'SymbolField(x: $x, y: $y, symbol: $value)';
  }
}
