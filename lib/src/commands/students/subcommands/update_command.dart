import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/student.dart';
import '../../../repositories/product_dio_repository.dart';
// import '../../../repositories/product_repository.dart';
import '../../../repositories/student_dio_repository.dart';
// import '../../../repositories/student_repository.dart';

class UpdateCommand extends Command {
  final StudentDioRepository studentRepository;
  final ProductDioRepository productRepository;

  @override
  String get description => 'Update a student';

  @override
  String get name => 'update';

  UpdateCommand(this.studentRepository)
      : productRepository = ProductDioRepository() {
    argParser.addOption('file', abbr: 'f', help: 'CSV file path');
    argParser.addOption('id', abbr: 'i', help: 'The id of student to be updated');
  }

  @override
  Future<void> run() async {
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (id == null) {
      print('Insira o Id do aluno (--id=0 ou -i 0)');
      return;
    }

    final students = File(filePath).readAsLinesSync();
    print('Aguarde, atualizando dados do aluno...');
    print('---------------------------------------------------------');

    if (students.length > 1) {
      print('Insira somente um aluno no arquivo $filePath');
      return;
    } else if (students.isEmpty) {
      print('Por favor, insira um aluno no arquivo $filePath');
      return;
    }

    var student = students.first;

    final studentData = student.split(';');
    final courseCsv = studentData[2].split(',').map(((course) => course.trim())).toList();

    final coursesData = courseCsv.map((course) async {
      final courseObject = await productRepository.findByName(course);
      courseObject.isStudent = true;
      return courseObject;
    }).toList();
    final courses = await Future.wait(coursesData);

    final addStudent = Student(
      id: int.parse(id),
      name: studentData[0],
      age: int.tryParse(studentData[1]),
      nameCourses: courseCsv,
      courses: courses,
      address: Address(
        street: studentData[3],
        number: int.parse(studentData[4]),
        zipCode: studentData[5],
        city: City(
          id: int.parse(studentData[6]),
          name: studentData[7],
        ),
        phone: Phone(
          ddd: int.parse(studentData[8]),
          phone: studentData[9],
        ),
      ),
    );

    studentRepository.update(addStudent);
    print('---------------------------------------------------------');
    print('Aluno atualizado com sucesso!');
  }
}
