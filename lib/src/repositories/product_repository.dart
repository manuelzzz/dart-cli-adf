import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/courses.dart';

class ProductRepository {
  Future<Courses> findByName(String courseName) async {
    final response = await http.get(Uri.parse('http://localhost:8080/products?name=$courseName'));
    if (response.statusCode != 200) {
      throw Exception();
    }

    final responseData = jsonDecode(response.body);
    if (responseData.isEmpty) {
      throw Exception('O produto não foi encontrado');
    }

    return Courses.fromMap(responseData.first); // caso não exista, retorna erro.
  }
}
