// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/models/task.dart';

class Cache {
  Repo currentRepo;
  List<Task> tasks;
  String? apiKey;
  DateTime? lastPush;
  DateTime? lastPull;
  Cache({
    required this.currentRepo,
    required this.tasks,
    this.apiKey,
    this.lastPush,
    this.lastPull,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentRepo': currentRepo.toMap(),
      'tasks': tasks.map((x) => x.toMap()).toList(),
      'apiKey': apiKey,
      'lastPush': lastPush != null ? Config.dateFormat.format(lastPush!) : null,
      'lastPull': lastPull != null ? Config.dateFormat.format(lastPull!) : null
    };
  }

  factory Cache.fromMap(Map<String, dynamic> map) {
    return Cache(
      currentRepo: Repo.fromMap(map['currentRepo'] as Map<String, dynamic>),
      tasks: (map['tasks'] as List).map((task) => Task.fromMap(task)).toList(),
      apiKey: map['apiKey'] != null ? map['apiKey'] as String : "",
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

  Cache copyWith({
    Repo? currentRepo,
    List<Task>? tasks,
    String? apiKey,
    DateTime? lastPush,
    DateTime? lastPull,
  }) {
    return Cache(
      currentRepo: currentRepo ?? this.currentRepo,
      tasks: tasks ?? this.tasks,
      apiKey: apiKey ?? this.apiKey,
      lastPush: lastPush ?? this.lastPush,
      lastPull: lastPull ?? this.lastPull,
    );
  }
}
