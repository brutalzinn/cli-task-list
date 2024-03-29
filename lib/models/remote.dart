// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Remote {
  String name;
  String url;
  Remote({
    required this.name,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory Remote.fromMap(Map<String, dynamic> map) {
    return Remote(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Remote.fromJson(String source) =>
      Remote.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Remote(name: $name, url: $url)';
}
