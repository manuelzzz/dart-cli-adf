import 'package:dio/dio.dart';
import '../models/courses.dart';

class ProductDioRepository {
  Future<Courses> findByName(String courseName) async {
    try {
      final response = await Dio().get('http://localhost:8080/products',
          queryParameters: {"name": courseName});

      // não precisa verificar o status code porque o DIO retorna uma excessão
      // não é necessário o jsonDecode porque o DIO já faz isso com o .data
      if (response.data.isEmpty) {
        throw Exception('O produto não foi encontrado');
      }

      return Courses.fromMap(response.data.first);
    } on DioError {
      throw Exception();
    }
  }
}
