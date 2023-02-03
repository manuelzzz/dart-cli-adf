import 'package:args/command_runner.dart';
import '../../../repositories/student_repository.dart';

class FindByIdCommand extends Command {
  final StudentRepository studentRepository;

  @override
  String get description => 'Find a student by id';

  @override
  String get name => 'byId';

  FindByIdCommand(this.studentRepository) {
    argParser.addOption('id', abbr: 'i', help: 'Student Id');
  }

  @override
  Future<void> run() async {
    if (argResults?['id'] == null) {
      print('Envie o id do aluno da forma correta (--id ou -i)');
      return;
    }

    final id = int.parse(argResults?['id']);
    print('Buscando aluno...');

    final student = await studentRepository.findById(id);
    print('---------------------------------------------------------');
    print('Nome: ${student.name}');
    print('Idade: ${student.age ?? 'Não informada'}');
    student.nameCourses.forEach(print);
    print('Endereço:');
    print('   Rua: ${student.address.street}');
    print('   Numero: ${student.address.number}');
    print('   CEP: ${student.address.zipCode}');
    print('---------------------------------------------------------');
  }
}
