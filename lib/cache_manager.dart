// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/remote.dart';
import 'package:path/path.dart' as Path;

import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/cache.dart';
import 'package:auto_assistant_cli/models/repo.dart';

class CacheManager {
  Cache? cache;
  static final filename = "cache.json";
  CacheManager({
    this.cache,
  });

  void save() {
    final repoDirectory = Directory(Config.cacheDirectory);
    final filePath = Path.join(repoDirectory.path, filename);
    String json = cache!.toJson();
    File(filePath).writeAsString(json);
    ConsoleWritter.write("Cache saved");
  }

  static CacheManager? load() {
    final repoDirectory = Directory(Config.cacheDirectory);
    final filePath = Path.join(repoDirectory.path, filename);
    final jsonString = File(filePath).readAsStringSync();
    if (jsonString.isEmpty) {
      return null;
    }
    return CacheManager.fromJson(jsonString);
  }

  void refresh() {
    final cacheManager = CacheManager.load();
    if (cacheManager == null) {
      ConsoleWritter.writeWarning("Cant refresh cache");
      return;
    }
    final oldTasks = cacheManager.cache?.tasks ?? [];
    final oldRemotes = cacheManager.cache?.currentRepo.remotes ?? [];
    cache!.tasks.clear();
    cache!.tasks.addAll(oldTasks);
    cache!.currentRepo.remotes.clear();
    cache!.currentRepo.remotes.addAll(oldRemotes);
    cache!.accessToken = cacheManager.cache?.accessToken;
    cache!.refreshToken = cacheManager.cache?.refreshToken;
  }

  static void initialize() {
    final cacheDirectory = Directory(Config.cacheDirectory);
    final repoExists = cacheDirectory.existsSync();
    if (repoExists == false) {
      cacheDirectory.create();
      final defaultRepo = Repo("default", "Default repo",
          remotes: [Remote(name: "origin", url: Config.apiBaseUrl)]);
      Config.cacheManager =
          CacheManager(cache: Cache(currentRepo: defaultRepo, tasks: []));
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
