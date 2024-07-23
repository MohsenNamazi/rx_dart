import 'dart:convert';
import 'dart:io';

import 'package:rx_dart/data/models/animal.dart';
import 'package:rx_dart/data/models/person.dart';
import 'package:rx_dart/data/models/thing.dart';

class Api {
  List<Animal>? _animals;
  List<Person>? _persons;
  Api();

  Future<List<Thing>> search(String query) async {
    final term = query.trim().toLowerCase();

    final cachedResult = _extractThingsUsingString(term);
    if (cachedResult != null) {
      return cachedResult;
    }

    // Call the API

    final persons = await _getJson('http://127.0.0.1:5500/apis/persons.json')
        .then((json) => json.map((value) => Person.fromJson(value)));

    _persons = persons.toList();

    final animals = await _getJson('http://127.0.0.1:5500/apis/animals.json')
        .then((json) => json.map((value) => Animal.fromJson(value)));

    _animals = animals.toList();

    return _extractThingsUsingString(term) ?? [];
  }

  List<Thing>? _extractThingsUsingString(String term) {
    final cachedAnimals = _animals;
    final cachedPersons = _persons;

    if (cachedAnimals != null && cachedPersons != null) {
      List<Thing> result = [];

      // go through animals
      for (final animal in cachedAnimals) {
        if (animal.type.name.trimmedContains(term)) {
          result.add(animal);
        }
      }

      // go through persons
      for (final person in cachedPersons) {
        if (person.name.trimmedContains(term)) {
          result.add(person);
        }
      }
      return result;
    } else {
      return null;
    }
  }

  Future<List<dynamic>> _getJson(String url) => HttpClient()
      .getUrl(Uri.parse(url))
      .then((req) => req.close())
      .then((res) => res.transform(utf8.decoder).join())
      .then((jsonString) => json.decode(jsonString) as List<dynamic>);
}

extension TrimmedCaseInsensitiveContain on String {
  bool trimmedContains(String other) =>
      trim().toLowerCase().contains(other.trim().toLowerCase());
}
