// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/models/task.dart';
import 'package:path/path.dart' as Path;

class StorageManager {
  final Repo repo;
  final List<Task> tasks;
  StorageManager({
    required this.repo,
    required this.tasks,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'repo': repo.toMap(),
      'tasks': tasks.map((x) => x.toMap()).toList(),
    };
  }

  factory StorageManager.fromMap(Map<String, dynamic> map) {
    return StorageManager(
      repo: Repo.fromMap(map['repo'] as Map<String, dynamic>),
      tasks: List<Task>.from(
        (map['tasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory StorageManager.fromJson(String source) =>
      StorageManager.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StorageManager(repo: $repo, tasks: $tasks)';

  void save() {
    final repoDirectory = Directory(Config.repoDirectory);
    final filePath = Path.join(repoDirectory.path, "${repo.name}.json");
    String json = jsonEncode(this);
    File(filePath).writeAsString(json);
  }

  static void createIfNotExists() {
    final repoDirectory = Directory(Config.repoDirectory);
    final repoExists = repoDirectory.existsSync();
    if (repoExists == false) {
      repoDirectory.create();
      final repo = Repo("default", "", createAt: DateTime.now());
      StorageManager(repo: repo, tasks: []).save();
    }
  }

  static StorageManager load(String repoName) {
    final repoDirectory = Directory(Config.repoDirectory);
    final filePath = Path.join(repoDirectory.path, "$repoName.json");
    final jsonString = File(filePath).readAsStringSync();
    Map<String, dynamic> map = jsonDecode(jsonString);
    return StorageManager.fromMap(map);
  }
}
