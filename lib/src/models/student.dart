// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'address.dart';
import 'courses.dart';

class Student {
  final int? id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<Courses> courses;
  final Address address;

  Student({
    this.id,
    required this.name,
    this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      "id": id,
      "name": name,
      "courses": courses.map((course) => course.toMap()).toList(),
      "endereco": address.toMap(),
    };
    if (age != null) {
      map['age'] = age;
    }
    return map;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'],
      nameCourses: List<String>.from(map['nameCourses'] ?? <String>[]),
      courses: map['courses']
              ?.map<Courses>((courseMap) => Courses.fromMap(courseMap))
              .toList() ??
          <Courses>[],
      address: Address.fromMap(map['address'] ?? <String, dynamic>{}),
    );
  }

  toJson() => jsonEncode(toMap());

  factory Student.fromJson(String json) => Student.fromMap(jsonDecode(json));

  @override
  String toString() {
    return 'Student(id: $id, name: $name, age: $age, nameCourses: $nameCourses, courses: $courses, adress: $address)';
  }
}
