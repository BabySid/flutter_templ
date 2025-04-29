import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_teml/src/models/json_models.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class JsonModelsPage extends StatefulWidget implements NameProvider {
  static const String _name = "JsonModels";
  @override
  String get name => _name;

  const JsonModelsPage({super.key});

  @override
  State<JsonModelsPage> createState() => _JsonModelsPageState();
}

class _JsonModelsPageState extends State<JsonModelsPage> {
  final person = Person(
    firstName: '张',
    lastName: '三',
    dateOfBirth: DateTime(1990, 1, 1),
    lowerCamelCase: 42,
  );

  late String jsonValue;
  late Person personValue;
  @override
  void initState() {
    jsonValue = json.encode(person.toJson());
    personValue = Person.fromJson(json.decode(jsonValue));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Json数据格式：$jsonValue"),
          Divider(),
          Text(
            "Person对象：${personValue.firstName} ${personValue.lastName} ${personValue.dateOfBirth} ${personValue.lowerCamelCase}",
          ),
        ],
      ),
    );
  }
}
