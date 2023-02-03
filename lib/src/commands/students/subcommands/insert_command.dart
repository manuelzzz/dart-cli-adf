import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../models/address.dart';
import '../../../models/city.dart';
 import '../../../models/phone.dart';
import '../../../models/student.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class InsertCommand extends Command {
  final StudentRepository studentRepository;
  final ProductRepository productRepository;

  @override
  String get description => 'Insert all students in csv file';

  @override
  String get name => 'insert';

  InsertCommand(this.studentRepository)
      : productRepository = ProductRepository() {
    argParser.addOption('file', abbr: 'f', help: 'CSV file path');
  }

  @override
  Future<void> run() async {
    print('Aguarde...');
    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync();
    print('---------------------------------------------------------');

    for (var student in students) {
      final studentData = student.split(';');
      // excracting the courses names and courses that student "isStudent"
      final courseCsv = studentData[2].split(',').map(((course) => course.trim())).toList();

      final coursesData = courseCsv.map((course) async {
        final courseObject = await productRepository.findByName(course);
        courseObject.isStudent = true;
        return courseObject;
      }).toList();
      final courses = await Future.wait(coursesData);

      final addStudent = Student(
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

      studentRepository.insert(addStudent);
    }
    print('---------------------------------------------------------');
    print('Alunos adicionados com sucesso!');
  }
}
