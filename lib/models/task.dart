// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:auto_assistant_cli/config.dart';

class Task {
  String title;
  String description;
  String text;
  DateTime? createAt;
  DateTime? updateAt;
  Task(
    this.title,
    this.description,
    this.text, {
    this.createAt,
    this.updateAt,
  }) {
    createAt ??= DateTime.now();
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(map['title'] as String, map['description'] as String,
        map['text'] as String,
        createAt: map['createAt'] != null
            ? Config.dateFormat.parse(map['createAt'] as String)
            : null,
        updateAt: map['updateAt'] != null
            ? Config.dateFormat.parse(map['updateAt'] as String)
            : null);
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'text': text,
      'createAt': createAt != null ? Config.dateFormat.format(createAt!) : null,
      'updateAt': updateAt != null ? Config.dateFormat.format(updateAt!) : null,
    };
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(title: $title, description: $description, createAt: $createAt, updateAt: $updateAt)';
  }
}
