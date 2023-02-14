// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:auto_assistant_cli/config.dart';

class Task {
  final String name;
  final String description;
  final DateTime createAt;
  final DateTime updateAt;
  Task(
    this.name,
    this.description,
    this.createAt,
    this.updateAt,
  );

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      map['name'] as String,
      map['description'] as String,
     Config.dateFormat.parse(map['createAt'] as String),
      Config.dateFormat.parse(map['updateAt'] as String),
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'createAt': Config.dateFormat.format(createAt),
      'updateAt': Config.dateFormat.format(updateAt),
    };
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(name: $name, description: $description, createAt: $createAt, updateAt: $updateAt)';
  }
}
