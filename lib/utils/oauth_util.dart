import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/access_token.dart';
import 'package:http/http.dart' as httpClient;

typedef CodeCallback = FutureOr<String> Function(String code);

class OAuthUtil {
  static Future<AccessToken> getAuthorization(String code) async {
    final basicAuth =
        'Basic ${base64.encode(utf8.encode('${Config.clientId}:${Config.clientSecret}'))}';

    final Uri uri = Uri.parse(Config.oAuthTokenServerUrl);
    final response = await httpClient.post(
      uri,
      body: {
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": Config.oAuthRedirectURL
      },
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": basicAuth
      },
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      final accessToken = AccessToken.fromJson(response.body);
      ConsoleWritter.write('status code 200 ${accessToken.accessToken}');

      return accessToken;
    } else {
      throw Exception(
          'Failed to send multipart request: ${response.statusCode}');
    }
  }

  static Future<String> listenCallback() async {
    final server = await HttpServer.bind(InternetAddress.anyIPv4, 8888);
    String received = "";
    print('Server listening on port ${server.port}');
    await for (var request in server) {
      await _handleRequest(request, (code) async {
        ConsoleWritter.write('Received code parameter: $code');
        return code;
      });
    }
    return received;
  }

  static Future<void> _handleRequest(
      HttpRequest request, CodeCallback callback) async {
    final code = request.uri.queryParameters['code'];
    if (code != null) {
      await callback(code);
      return;
    }
    await request.response.close();
  }
}
