import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/access_token.dart';

typedef StringVoidFunc = void Function(String);

class OAuthUtil {
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
