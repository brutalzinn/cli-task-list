// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/models/task.dart';
import 'package:path/path.dart' as Path;

class RepoManager {
  final Repo repo;
  final List<Task> tasks;
  RepoManager({
    required this.repo,
    required this.tasks,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'repo': repo.toMap(),
      'tasks': tasks.map((x) => x.toMap()).toList(),
    };
  }

  factory RepoManager.fromMap(Map<String, dynamic> map) {
    return RepoManager(
      repo: Repo.fromMap(map['repo'] as Map<String, dynamic>),
      tasks: (map['tasks'] as List).map((task) => Task.fromMap(task)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RepoManager.fromJson(String source) =>
      RepoManager.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RepoManager(repo: $repo, tasks: $tasks)';

  void save() {
    final repoDirectory = Directory(Config.repoDirectory);
    final filePath = Path.join(repoDirectory.path, "${repo.fileName}.json");
    String json = toJson();
    File(filePath).writeAsString(json);
  }

  static void createIfNotExists() {
    final repoDirectory = Directory(Config.repoDirectory);
    final repoExists = repoDirectory.existsSync();
    if (repoExists == false) {
      repoDirectory.create();
      final repo = Repo("default", "", createAt: DateTime.now());
      RepoManager(repo: repo, tasks: []).save();
    }
  }

  static RepoManager load(String fileName) {
    final repoDirectory = Directory(Config.repoDirectory);
    final filePath = Path.join(repoDirectory.path, "$fileName.json");
    final jsonString = File(filePath).readAsStringSync();
    return RepoManager.fromJson(jsonString);
  }
}
