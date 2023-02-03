// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Courses {
  int id;
  String name;
  bool isStudent;

  Courses({
    required this.id,
    required this.name,
    required this.isStudent,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "isStudent": isStudent,
    };
  }

  factory Courses.fromMap(Map<String, dynamic> map) {
    return Courses(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      isStudent: map['isStudent'] ?? false,
    );
  }

  toJson() => jsonEncode(toMap());

  factory Courses.fromJson(String json) => Courses.fromMap(jsonDecode(json));

  @override
  String toString() => 'Courses(id: $id, name: $name, isStudent: $isStudent)';
}
