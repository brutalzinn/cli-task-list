// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/repo.dart';

class Cache {
  Repo currentRepo;
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
    Repo? currentRepo,
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
      'currentRepo': currentRepo.toMap(),
      'apiKey': apiKey,
      'lastPush': lastPush != null ? Config.dateFormat.format(lastPush!) : null,
      'lastPull': lastPull != null ? Config.dateFormat.format(lastPull!) : null,
    };
  }

  factory Cache.fromMap(Map<String, dynamic> map) {
    return Cache(
        currentRepo: Repo.fromMap(map['currentRepo'] as Map<String, dynamic>),
        apiKey: map['apiKey'] != null ? map['apiKey'] as String : null,
        lastPush: map['lastPush'] != null
            ? Config.dateFormat.parse(map['lastPush'] as String)
            : null,
        lastPull: map['lastPull'] != null
            ? Config.dateFormat.parse(map['lastPull'] as String)
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Cache.fromJson(String source) =>
      Cache.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cache(currentRepo: $currentRepo, apiKey: $apiKey, lastPush: $lastPush, lastPull: $lastPull)';
  }

  @override
  bool operator ==(covariant Cache other) {
    if (identical(this, other)) return true;

    return other.currentRepo == currentRepo &&
        other.apiKey == apiKey &&
        other.lastPush == lastPush &&
        other.lastPull == lastPull;
  }

  @override
  int get hashCode {
    return currentRepo.hashCode ^
        apiKey.hashCode ^
        lastPush.hashCode ^
        lastPull.hashCode;
  }
}
