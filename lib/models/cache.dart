// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:auto_assistant_cli/models/remote.dart';
import 'package:collection/collection.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/models/task.dart';

class Cache {
  Repo currentRepo;
  List<Task> tasks;
  String? defaultEditorPath;
  DateTime? lastPush;
  DateTime? lastPull;
  Cache({
    required this.currentRepo,
    required this.tasks,
    this.defaultEditorPath,
    this.lastPush,
    this.lastPull,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentRepo': currentRepo.toMap(),
      'tasks': tasks.map((x) => x.toMap()).toList(),
      'defaultEditorPath': defaultEditorPath,
      'lastPush': lastPush != null ? Config.dateFormat.format(lastPush!) : null,
      'lastPull': lastPull != null ? Config.dateFormat.format(lastPull!) : null
    };
  }

  factory Cache.fromMap(Map<String, dynamic> map) {
    return Cache(
      currentRepo: Repo.fromMap(map['currentRepo'] as Map<String, dynamic>),
      tasks: (map['tasks'] as List).map((task) => Task.fromMap(task)).toList(),
      defaultEditorPath: map['defaultEditorPath'] != null
          ? map['defaultEditorPath'] as String
          : "",
      lastPush: map['lastPush'] != null
          ? Config.dateFormat.parse(map['lastPush'] as String)
          : null,
      lastPull: map['lastPull'] != null
          ? Config.dateFormat.parse(map['lastPull'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cache.fromJson(String source) =>
      Cache.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cache(currentRepo: $currentRepo, tasks: $tasks, lastPush: $lastPush, lastPull: $lastPull)';
  }
}
