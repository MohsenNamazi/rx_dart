import 'package:flutter/foundation.dart' show immutable;
import 'package:rx_dart/data/models/thing.dart';

enum AnimalType { dog, cat, rabbit, unknown }

@immutable
class Animal extends Thing {
  final AnimalType type;
  const Animal({
    required super.name,
    required this.type,
  });

  @override
  String toString() => 'Animal, name: $name, type: $type';

  factory Animal.fromJson(Map<String, dynamic> json) {
    final AnimalType animalType;

    switch ((json['type'] as String).toLowerCase().trim()) {
      case 'cat':
        animalType = AnimalType.cat;
      case 'dog':
        animalType = AnimalType.dog;
      case 'rabbit':
        animalType = AnimalType.rabbit;
      default:
        animalType = AnimalType.unknown;
    }

    return Animal(name: json['name'], type: animalType);
  }
}
