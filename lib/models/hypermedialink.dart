// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HypermediaLink {
  String href;
  String type;

  HypermediaLink({required this.href, required this.type});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'href': href,
      'type': type,
    };
  }

  factory HypermediaLink.fromMap(Map<String, dynamic> map) {
    return HypermediaLink(
      href: map['href'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HypermediaLink.fromJson(String source) =>
      HypermediaLink.fromMap(json.decode(source) as Map<String, dynamic>);
}
