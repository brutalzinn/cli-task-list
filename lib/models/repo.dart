import 'dart:convert';

import 'package:auto_assistant_cli/config.dart';

class Repo {
  String name;
  String description;
  String fileName;
  DateTime? createAt;
  DateTime? updateAt;

  Repo(this.name, this.description,
      {this.fileName = "default", this.createAt, this.updateAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'filename': fileName,
      'createAt': createAt != null ? Config.dateFormat.format(createAt!) : null,
      'updateAt': updateAt != null ? Config.dateFormat.format(updateAt!) : null,
    };
  }

  factory Repo.fromMap(Map<String, dynamic> map) {
    return Repo(
      map['name'] as String,
      map['description'] as String,
      fileName: map['filename'],
      createAt: map['createAt'] != null
          ? Config.dateFormat.parse(map['createAt'] as String)
          : null,
      updateAt: map['updateAt'] != null
          ? Config.dateFormat.parse(map['updateAt'] as String)
          : null,
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
