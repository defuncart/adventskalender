import 'dart:io';

import 'package:adventskalender/configs/constants.dart';
import 'package:adventskalender/models/advent_day.dart';
import 'package:args/args.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';

void main(List<String> arguments) async {
  // cleanup
  if (!await Directory('assets/database').exists()) {
    await Directory('assets/database').create();
  }
  await Directory('assets/database').list().listen((entity) async => await entity.delete());

  // variables
  Directory dir;

  // setup parser
  final parser = ArgParser()
    ..addSeparator('Generates the db bundled with app.')
    ..addOption('dir', abbr: 'd', help: 'The directory from which to import.', valueHelp: 'DIR')
    ..addFlag('help', abbr: 'h', negatable: false, defaultsTo: false, help: 'Displays help.');
  final args = parser.parse(arguments);

  // process arguments
  if (args['help']) {
    print(parser.usage);
    exit(0);
  } else {
    final dirArg = args['dir'].toString();
    if (dirArg == null) {
      printError('No dir value specified. Please see help for more info.');
    }

    dir = Directory('assets_dev/database/$dirArg');
    if (!await dir.exists()) {
      printError('Directory ${dir.path} not found. Maybe an incorrect parameter was specified as CLA?');
    }
  }

  // determine if all images are present
  final imageList = await _filesOfTypeInDir('jpeg', dir);
  if (imageList.length != numberDaysAdvent) {
    printError('Exactly $numberDaysAdvent images are expected.');
  }
  final expectedFileNames = List.generate(numberDaysAdvent, (index) => (index + 1).toString());
  for (final imageFilepath in imageList) {
    final filename = basename(imageFilepath).replaceAll('.jpeg', '');
    if (!expectedFileNames.contains(filename)) {
      printError('$imageFilepath isn\'t valid. Expected named from 1 to 24.');
    }
  }

  // move all images
  for (final imageFilepath in imageList) {
    final file = File(imageFilepath);
    await file.copy('assets/database/${basename(imageFilepath)}');
  }

  // parse db
  final parsedLines = <List<String>>[];
  final csvFilepaths = await _filesOfTypeInDir('csv', dir);
  if (csvFilepaths.isEmpty) {
    printError('No csv db found in ${dir.path}!');
  }
  final csvFileContents = await File(csvFilepaths.first).readAsLines();
  if (csvFileContents.length != (numberDaysAdvent + 1)) {
    printError('CSV file ${csvFilepaths.first} has ${csvFileContents.length} lines, expected ${numberDaysAdvent + 1}');
  }
  for (var line = 1; line < csvFileContents.length; line++) {
    final components = csvFileContents[line].split(';');
    if (components.length != 5) {
      printError('Line number $line with contents ${csvFileContents[line]} is not well formatted.');
    }
    parsedLines.add(components);
  }

  // save db
  Hive.init('assets/database');
  Hive.registerAdapter(AdventDayAdapter());
  final box = await Hive.openBox<AdventDay>('db');

  for (final components in parsedLines) {
    await box.add(AdventDay(
      title: components[1],
      description: components[2],
      value1: components[3],
      value2: components[4],
    ));
  }

  print('DB generated!');
}

void printError(String error, {bool shouldExitProgram = true}) {
  print('Error! $error');
  if (shouldExitProgram) {
    exit(0);
  }
}

Future<List<String>> _filesOfTypeInDir(String filetype, Directory dir) async {
  final returnList = <String>[];
  await dir.list().listen((entity) {
    if (entity is File) {
      if (entity.path.split('.').last == filetype) {
        returnList.add(entity.path);
      }
    }
  });

  await Future.delayed(Duration(milliseconds: 100));

  return returnList;
}
