// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class City {
  int id;
  String name;

  City({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  toJson() => jsonEncode(toMap());

  factory City.fromJson(String json) => City.fromMap(jsonDecode(json));
}
