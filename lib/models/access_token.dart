// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccessToken {
  final String accessToken;
  final int expiresIn;
  final String scope;
  final String tokenType;
  final String refreshToken;

  AccessToken(
      {required this.accessToken,
      required this.expiresIn,
      required this.scope,
      required this.tokenType,
      required this.refreshToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'expires_in': expiresIn,
      'scope': scope,
      'token_type': tokenType,
      'refresh_token': refreshToken,
    };
  }

  factory AccessToken.fromMap(Map<String, dynamic> map) {
    return AccessToken(
      accessToken: map['access_token'] as String,
      expiresIn: map['expires_in'] as int,
      scope: map['scope'] as String,
      tokenType: map['token_type'] as String,
      refreshToken: map['refresh_token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccessToken.fromJson(String source) =>
      AccessToken.fromMap(json.decode(source) as Map<String, dynamic>);
}
