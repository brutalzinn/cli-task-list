// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:auto_assistant_cli/config.dart';

class Cache {
  String currentRepo;
  String? apiKey;
  DateTime? lastPush;
  DateTime? lastPull;
  Cache({
    required this.currentRepo,
    this.apiKey,
    this.lastPush,
    this.lastPull,
  });

  Cache copyWith({
    String? currentRepo,
    String? apiKey,
    DateTime? lastPush,
    DateTime? lastPull,
  }) {
    return Cache(
      currentRepo: currentRepo ?? this.currentRepo,
      apiKey: apiKey ?? this.apiKey,
      lastPush: lastPush ?? this.lastPush,
      lastPull: lastPull ?? this.lastPull,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentRepo': currentRepo,
      'apiKey': apiKey,
      'lastPush': lastPush != null ? Config.dateFormat.format(lastPush!) : null,
      'lastPull': lastPull != null ? Config.dateFormat.format(lastPull!) : null,
    };
  }

  factory Cache.fromMap(Map<String, dynamic> map) {
    return Cache(
      currentRepo: map['currentRepo'] as String,
      apiKey: map['apiKey'] as String,
      lastPush: Config.dateFormat.parse(map['lastPush'] as String),
      lastPull: Config.dateFormat.parse(map['lastPull'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cache.fromJson(String source) =>
      Cache.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cache(currentRepo: $currentRepo, apiKey: $apiKey, lastPush: $lastPush, lastPull: $lastPull)';
  }
}
