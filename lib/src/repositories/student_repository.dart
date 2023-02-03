import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/student.dart';

class StudentRepository {
  Future<List<Student>> findAll() async {
    final studentResponse =
        await http.get(Uri.parse('http://localhost:8080/students'));
    if (studentResponse.statusCode != 200) {
      throw Exception();
    }

    final studentsData = jsonDecode(studentResponse.body);

    return studentsData
        .map<Student>((studentMap) => Student.fromMap(studentMap))
        .toList();
  }

  Future<Student> findById(int id) async {
    final studentResponse =
        await http.get(Uri.parse('http://localhost:8080/students/$id'));

    if (studentResponse.statusCode != 200) {
      throw Exception();
    }
    if (studentResponse.body == '{}') {
      throw Exception();
    }

    return Student.fromJson(studentResponse.body);
  }

  Future<void> insert(Student student) async {
    final response = await http.post(
        Uri.parse('http://localhost:8080/students'),
        body: student.toJson(),
        headers: {'content-type': 'aplication/json'});

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> update(Student student) async {
    final response = await http.put(
        Uri.parse('http://localhost:8080/students/${student.id}'),
        body: student.toJson(),
        headers: {'content-type': 'aplication/json'});

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
