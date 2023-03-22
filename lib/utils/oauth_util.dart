import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/access_token.dart';
import 'package:http/http.dart' as httpClient;

typedef StringVoidFunc = void Function(String);

class OAuthUtil {
  static Future<AccessToken> authorization(String code) async {
    final basicAuth =
        'Basic ${base64.encode(utf8.encode('${Config.clientId}:${Config.clientSecret}'))}';
    ConsoleWritter.writeWarning(basicAuth);
    final Uri uri = Uri.parse(Config.oAuthTokenServerUrl);
    final body = {
      "grant_type": "authorization_code",
      "code": code,
      "redirect_uri": Config.oAuthRedirectURL
    };
    final headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": basicAuth
    };
    final response = await httpClient.post(uri, body: body, headers: headers);
    final accessToken = AccessToken.fromJson(response.body);
    if (response.statusCode == 200) {
      return accessToken;
    } else {
      throw Exception(
          'Failed to send multipart request: ${response.statusCode}');
    }
  }

  static Future<AccessToken> refreshToken(String refreshToken) async {
    final basicAuth =
        'Basic ${base64.encode(utf8.encode('${Config.clientId}:${Config.clientSecret}'))}';
    ConsoleWritter.writeWarning(basicAuth);
    final Uri uri = Uri.parse(Config.oAuthTokenServerUrl);
    final body = {"grant_type": "refresh_token", "refresh_token": refreshToken};
    final headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": basicAuth
    };
    final response = await httpClient.post(uri, body: body, headers: headers);
    final accessToken = AccessToken.fromJson(response.body);
    if (response.statusCode == 200) {
      return accessToken;
    } else {
      throw Exception(
          'Failed to send multipart request: ${response.statusCode}');
    }
  }

  static void waitCodeOAuth(StringVoidFunc callback) async {
    final server = await HttpServer.bind(InternetAddress.anyIPv4, 8888);
    await for (var request in server) {
      final code = _handleRequest(request);
      callback(code);
    }
  }

  static String _handleRequest(HttpRequest request) {
    final code = request.uri.queryParameters['code'];
    if (code != null) {
      return code;
    }
    return "";
  }
}
