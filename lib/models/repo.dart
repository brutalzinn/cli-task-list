import 'dart:convert';

import 'package:auto_assistant_cli/config.dart';

class Repo {
  final String name;
  final String description;
  DateTime? createAt;
  DateTime? updateAt;

  Repo(this.name, this.description, this.createAt, this.updateAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'createAt': Config.dateFormat.format(createAt ?? DateTime.now()),
      'updateAt': Config.dateFormat.format(updateAt ?? DateTime.now()),
    };
  }

  factory Repo.fromMap(Map<String, dynamic> map) {
    return Repo(
      map['name'] as String,
      map['description'] as String,
      Config.dateFormat.parse(map['createAt'] as String),
      Config.dateFormat.parse(map['updateAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Repo.fromJson(String source) =>
      Repo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Repo(name: $name, description: $description, createAt: $createAt, updateAt: $updateAt)';
  }
}
