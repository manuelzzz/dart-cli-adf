import 'package:adf_cli/src/commands/students/students_command.dart';
import 'package:args/command_runner.dart';
// import 'package:args/args.dart';
// import 'dart:io';

void main(List<String> arguments) {
  CommandRunner('ADF CLI', 'ADF ot add to a fixed-lenCLI')
    ..addCommand(StudentsCommand())
    ..run(arguments);
}
