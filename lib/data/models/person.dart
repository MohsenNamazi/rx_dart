import 'package:flutter/foundation.dart' show immutable;
import 'package:rx_dart/data/models/thing.dart';

@immutable
class Person extends Thing {
  final int age;
  const Person({
    required super.name,
    required this.age,
  });

  @override
  String toString() => 'Animal, name: $name, age: $age';

  Person.fromJson(Map<String, dynamic> json)
      : age = json['age'],
        super(name: json['name']);
}
