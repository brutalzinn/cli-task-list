// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:auto_assistant_cli/models/cache.dart';
import 'package:path/path.dart' as Path;
import 'package:auto_assistant_cli/config.dart';

class CacheManager {
  final Cache cache;
  CacheManager({
    required this.cache,
  });

  void save() {
    final repoDirectory = Directory(Config.cacheDirectory);
    final filePath = Path.join(repoDirectory.path, "default.json");
    String json = jsonEncode(cache.toJson());
    File(filePath).writeAsString(json);
  }

  static CacheManager load() {
    final repoDirectory = Directory(Config.cacheDirectory);
    final filePath = Path.join(repoDirectory.path, "default.json");
    final jsonString = File(filePath).readAsStringSync();
    Map<String, dynamic> map = jsonDecode(jsonString);
    return CacheManager.fromMap(map);
  }

  static void initialize() {
    final cacheDirectory = Directory(Config.cacheDirectory);
    final repoExists = cacheDirectory.existsSync();
    if (repoExists == false) {
      cacheDirectory.create();
      CacheManager(cache: Cache(currentRepo: "default")).save();
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cache': cache.toMap(),
    };
  }

  factory CacheManager.fromMap(Map<String, dynamic> map) {
    return CacheManager(
      cache: Cache.fromMap(map['cache'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CacheManager.fromJson(String source) =>
      CacheManager.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CacheManager(cache: $cache)';
}
