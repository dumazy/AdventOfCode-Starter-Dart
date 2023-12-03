import '../utils/index.dart';

final maxCombo = Combo(red: 12, blue: 14, green: 13);

class Day02 extends GenericDay {
  Day02() : super(2);

  final games = <Game>[];

  @override
  void parseInput() {
    games.clear();
    final lines = input.getPerLine();
    for (final line in lines) {
      final colonIndex = line.indexOf(':');
      final gameNumber = int.parse(line.substring('Game '.length, colonIndex));
      final comboData = line.substring(colonIndex + 2).split(';');
      final combos = comboData.map((comboLine) {
        final cubeData = comboLine.split(',');
        final singleColorCombos = cubeData.map((cube) {
          final data = cube.trim().split(' ');
          return switch (data.last) {
            'red' => Combo(red: int.parse(data.first)),
            'blue' => Combo(blue: int.parse(data.first)),
            'green' => Combo(green: int.parse(data.first)),
            _ => throw Exception('Invalid color'),
          };
        }).toList();
        return singleColorCombos.reduce((value, element) => value + element);
      }).toList();
      games.add(Game(number: gameNumber, combos: combos));
    }
  }

  @override
  int solvePart1() {
    parseInput();
    final validGames =
        games.where((game) => game.combos.every((combo) => combo <= maxCombo));
    final sumNumbers = validGames
        .map((game) => game.number)
        .reduce((value, element) => value + element);
    return sumNumbers;
  }

  @override
  int solvePart2() {
    parseInput();
    final lowestCombos = games.map(
        (game) => game.combos.reduce((value, element) => value.max(element)));
    final powerSum = lowestCombos
        .map((combo) => combo.power)
        .reduce((value, element) => value + element);
    return powerSum;
  }
}

class Game {
  Game({
    required this.number,
    required this.combos,
  });

  final int number;
  final List<Combo> combos;
}

class Combo {
  Combo({
    this.red = 0,
    this.blue = 0,
    this.green = 0,
  });

  final int red;
  final int blue;
  final int green;

  Combo operator +(Combo other) {
    return Combo(
      red: red + other.red,
      blue: blue + other.blue,
      green: green + other.green,
    );
  }

  bool operator <=(Combo other) {
    return red <= other.red && blue <= other.blue && green <= other.green;
  }

  Combo max(Combo other) {
    return Combo(
      red: red > other.red ? red : other.red,
      blue: blue > other.blue ? blue : other.blue,
      green: green > other.green ? green : other.green,
    );
  }

  int get power => red * blue * green;
}
