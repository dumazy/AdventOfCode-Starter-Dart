import 'dart:convert';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

/// Tool to generate test cases with Gemini for a given AOC day
void main([List<String>? args]) async {
  assert(args!.length == 2, 'Should have 2 args');
  final [String apiKey, String day] = args!;
  final dayNumber = int.parse(day);
  final puzzle = await getDayPuzzle(dayNumber);
  final textFileContent = await getTestFileContent(puzzle, apiKey);
  if (textFileContent == null) {
    print('Failed to generate test file content');
    return;
  }
  await writeToTestFile(dayNumber, textFileContent);
}

Future<String> getDayPuzzle(int day) async {
  print('Fetching puzzle for day $day...');
  const year = 2023;
  final request = await HttpClient().getUrl(
    Uri.parse(
      'https://adventofcode.com/$year/day/$day',
    ),
  );
  final response = await request.close();
  final body = await response.transform(const Utf8Decoder()).join();
  final puzzle =
      body.split('<article class="day-desc">')[1].split('</article>')[0];
  return puzzle;
}

Future<String?> getTestFileContent(String puzzle, String apiKey) async {
  print('Generating test file content...');
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  final prompt = '''
Generate a Dart file with unit tests for the cases that are mentioned in this puzzle.
There will be a class `DayXX` where `XX` is the day number available already, it can be imported as `import '../solutions/dayXX.dart';`.
This class will have a method `solvePart1` and `solvePart2` that will return the solution for the puzzle.
The input for the puzzle can be set with the setter `inputForTesting` which will take a string as input.
Only focus on the part 1 of the puzzle for now.
The response should exist only out of the generated Dart file content.
Do not include backticks or any other formatting in the response.
Only write tests for the cases that are mentioned in the puzzle.

Puzzle: $puzzle
''';
  final content = [Content.text(prompt)];
  final response = await model.generateContent(content);
  return response.text;
}

Future<void> writeToTestFile(int day, String? content) async {
  print('Writing to test file...');
  final testDir = Directory('test');
  if (!testDir.existsSync()) {
    testDir.createSync();
  }
  final testFileName = 'day${day.toString().padLeft(2, '0')}_test.dart';
  await File('test/$testFileName').writeAsString(content!);
}
