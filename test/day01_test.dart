import 'package:test/test.dart';
import '../solutions/day01.dart';

void main() {
  group('Day 1 - Part 1', () {
    late Day01 day01;

    setUp(() {
      day01 = Day01();
    });

    test('Example 1', () {
      day01.inputForTesting = '1abc2';
      expect(day01.solvePart1(), 12);
    });

    test('Example 2', () {
      day01.inputForTesting = 'pqr3stu8vwx';
      expect(day01.solvePart1(), 38);
    });

    test('Example 3', () {
      day01.inputForTesting = 'a1b2c3d4e5f';
      expect(day01.solvePart1(), 15);
    });

    test('Example 4', () {
      day01.inputForTesting = 'treb7uchet';
      expect(day01.solvePart1(), 77);
    });
  });
}
