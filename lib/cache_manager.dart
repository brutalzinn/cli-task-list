// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:path/path.dart' as Path;

import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/cache.dart';
import 'package:auto_assistant_cli/models/repo.dart';

class CacheManager {
  Cache? cache;
  CacheManager({
    this.cache,
  });

  void save() {
    final repoDirectory = Directory(Config.cacheDirectory);
    final filePath = Path.join(repoDirectory.path, "default.json");
    String json = cache!.toJson();
    File(filePath).writeAsString(json);
    ConsoleWritter.write("Cache saved");
  }

  static CacheManager? load() {
    final repoDirectory = Directory(Config.cacheDirectory);
    final filePath = Path.join(repoDirectory.path, "default.json");
    final jsonString = File(filePath).readAsStringSync();
    if (jsonString.isEmpty) {
      return null;
    }
    return CacheManager.fromJson(jsonString);
  }

  void refresh() {
    final cacheManager = CacheManager.load();
    if (cacheManager == null) {
      ConsoleWritter.writeImportant("Caution. You cache cant be loaded.");
      return;
    }
    final oldTasks = cacheManager.cache?.tasks ?? [];
    cache!.tasks.clear();
    cache!.tasks.addAll(oldTasks);
    cache!.apiUrl = cacheManager.cache!.apiUrl;
    cache!.apiKey = cacheManager.cache!.apiKey;
    cache!.remotes = cacheManager.cache!.remotes;
  }

  static void initialize() {
    final cacheDirectory = Directory(Config.cacheDirectory);
    final repoExists = cacheDirectory.existsSync();
    if (repoExists == false) {
      cacheDirectory.create();
      final defaultRepo = Repo("default", "Default repo");
      Config.cacheManager = CacheManager(
          cache: Cache(currentRepo: defaultRepo, remotes: [], tasks: []));
      Config.cacheManager.save();
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cache': cache != null ? cache!.toMap() : null,
    };
  }

  factory CacheManager.fromMap(Map<String, dynamic> map) {
    return CacheManager(cache: Cache.fromMap(map));
  }

  String toJson() => json.encode(toMap());

  factory CacheManager.fromJson(String source) =>
      CacheManager.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CacheManager(cache: $cache)';

  CacheManager copyWith({
    Cache? cache,
  }) {
    return CacheManager(
      cache: cache ?? this.cache,
    );
  }
}
