import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../models/student.dart';
import '../../../repositories/student_repository.dart';

class FindAllCommand extends Command {
  final StudentRepository repository;

  @override
  String get description => 'Find all students';

  @override
  String get name => 'findAll';

  FindAllCommand(this.repository);

  @override
  Future<void> run() async {
    print('Buscando alunos...');
    List<Student> students = await repository.findAll();

    if(students.isEmpty) {
      print('---------------------------------------------------------');
      print('Não há alunos a serem buscados');
      print('---------------------------------------------------------');
      return;
    }

    print('Apresentar também os cursos? (S ou N)');
    final showCourses = stdin.readLineSync();

    print('---------------------------------------------------------');
    print('Alunos:');
    print('---------------------------------------------------------');

    for (var student in students) {
      if (showCourses?.toLowerCase() == 's') {
        print(
            '${student.id} - ${student.name} - ${student.courses.where((course) => course.isStudent).map((e) => e.name).toList()}');
      } else if (showCourses?.toLowerCase() == 'n') {
        print('${student.id} - ${student.name}');
      } else {
        print('Esta opção não é válida');
      }
    }
  }
}
