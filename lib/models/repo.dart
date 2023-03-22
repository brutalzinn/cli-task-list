import 'dart:convert';

import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/remote.dart';

class Repo {
  String title;
  String description;
  String fileName;
  List<Remote> remotes;
  DateTime? createAt;
  DateTime? updateAt;

  Repo(this.title, this.description,
      {this.fileName = "default",
      required this.remotes,
      this.createAt,
      this.updateAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'fileName': fileName,
      'remotes': remotes.map((x) => x.toMap()).toList(),
      'createAt': createAt != null ? Config.dateFormat.format(createAt!) : null,
      'updateAt': updateAt != null ? Config.dateFormat.format(updateAt!) : null,
    };
  }

  factory Repo.fromMap(Map<String, dynamic> map) {
    return Repo(
      map['title'] as String,
      map['description'] as String,
      remotes: (map['remotes'] as List)
          .map((remote) => Remote.fromMap(remote))
          .toList(),
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
    return 'Repo(title: $title, description: $description, createAt: $createAt, updateAt: $updateAt)';
  }
}
