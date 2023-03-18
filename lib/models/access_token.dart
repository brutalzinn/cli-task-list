// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccessToken {
  final String accessToken;
  final int expiresIn;
  final String scope;
  final String tokenType;

  AccessToken({
    required this.accessToken,
    required this.expiresIn,
    required this.scope,
    required this.tokenType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'expiresIn': expiresIn,
      'scope': scope,
      'tokenType': tokenType,
    };
  }

  factory AccessToken.fromMap(Map<String, dynamic> map) {
    return AccessToken(
      accessToken: map['accessToken'] as String,
      expiresIn: map['expiresIn'] as int,
      scope: map['scope'] as String,
      tokenType: map['tokenType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccessToken.fromJson(String source) =>
      AccessToken.fromMap(json.decode(source) as Map<String, dynamic>);
}
