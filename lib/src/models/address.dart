// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'city.dart';
import 'phone.dart';

class Address {
  final String street;
  final int number;
  final String zipCode;
  final City city;
  final Phone phone;

  Address({
    required this.street,
    required this.number,
    required this.zipCode,
    required this.city,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      "street": street,
      "number": number,
      "zipCode": zipCode,
      "city": city.toMap(),
      "phone": phone.toMap()
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] ?? '',
      number: map['number'] ?? 0,
      zipCode: map['zipCode'] ?? '',
      city: City.fromMap(map['city'] ?? <String, dynamic>{}),
      phone: Phone.fromMap(map['phone'] ?? <String, dynamic>{}),
    );
  }

  toJson() => jsonEncode(toMap());

  factory Address.fromJson(String json) => Address.fromMap(jsonDecode(json));
}
