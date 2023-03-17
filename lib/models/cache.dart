// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:auto_assistant_cli/models/remote.dart';
import 'package:collection/collection.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/models/task.dart';

class Cache {
  Repo currentRepo;
  List<Remote> remotes;
  List<Task> tasks;
  String? apiKey;
  String? apiUrl;
  String? defaultEditorPath;
  DateTime? lastPush;
  DateTime? lastPull;
  Cache({
    required this.currentRepo,
    required this.remotes,
    required this.tasks,
    this.apiKey,
    this.apiUrl,
    this.defaultEditorPath,
    this.lastPush,
    this.lastPull,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentRepo': currentRepo.toMap(),
      'remotes': remotes.map((x) => x.toMap()).toList(),
      'tasks': tasks.map((x) => x.toMap()).toList(),
      'apiKey': apiKey,
      'apiUrl': apiUrl,
      'defaultEditorPath': defaultEditorPath,
      'lastPush': lastPush != null ? Config.dateFormat.format(lastPush!) : null,
      'lastPull': lastPull != null ? Config.dateFormat.format(lastPull!) : null
    };
  }

  factory Cache.fromMap(Map<String, dynamic> map) {
    return Cache(
      currentRepo: Repo.fromMap(map['currentRepo'] as Map<String, dynamic>),
      remotes:
          (map['remotes'] as List).map((task) => Remote.fromMap(task)).toList(),
      tasks: (map['tasks'] as List).map((task) => Task.fromMap(task)).toList(),
      apiKey: map['apiKey'] != null ? map['apiKey'] as String : "",
      apiUrl: map['apiUrl'] != null ? map['apiUrl'] as String : "",
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
    return 'Cache(currentRepo: $currentRepo, tasks: $tasks, apiKey: $apiKey, lastPush: $lastPush, lastPull: $lastPull)';
  }
}
