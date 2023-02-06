import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../repositories/student_dio_repository.dart';
// import '../../../repositories/student_repository.dart';

class DeleteCommand extends Command {
  final StudentDioRepository studentRepository;

  @override
  String get description => 'Delete a student';

  @override
  String get name => 'delete';

  DeleteCommand(this.studentRepository) {
    argParser.addOption('id',
        abbr: 'i', help: 'The id of student to be updated');
  }

  @override
  Future<void> run() async {
    print('Aguarde...');
    final id = int.tryParse(argResults?['id']);
    print('---------------------------------------------------------');

    if (id == null) {
      print('Insira o Id do aluno (--id=0 ou -i 0)');
      return;
    }

    try{
    final student = await studentRepository.findById(id);

    print('${student.id} | ${student.name}');
    print('tem certeza de que deseja deletar este aluno? (S ou N)');
    print('(ESTA OPÇÃO NÃO PODE SER REVERTIDA!!!)');
    print('---------------------------------------------------------');

    final option = stdin.readLineSync();

    if (option != null) {
      if (option.toLowerCase() == 's') {
        print('Deletando o aluno...');
        studentRepository.deleteById(id);
        print('---------------------------------------------------------');
        print('Aluno deletado com sucesso!');
      } else if (option.toLowerCase() == 'n') {
        print('---------------------------------------------------------');
        print('Operação cancelada com sucesso');
      }
    } else {
      print('Insira uma opção válida (S ou N)');
    }
    } catch(err) {
      print('Aluno não encontrado.');
    }
    
  }
}
