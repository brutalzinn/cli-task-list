import 'dart:async';
import 'dart:io';
import 'package:auto_assistant_cli/config.dart';

typedef CodeCallback = FutureOr<String> Function(String code);

class OAuthUtil {
  static Future<String> listenCallback() async {
    final server = await HttpServer.bind(InternetAddress.anyIPv4, 8888);
    print('Server listening on port ${server.port}');
    await for (var request in server) {
      _handleRequest(request, (code) async {
        print('Received code parameter: $code');
        return code;
      });
    }
    return "";
  }

  static Future<void> _handleRequest(
      HttpRequest request, CodeCallback callback) async {
    final code = request.uri.queryParameters['code'];
    if (code != null) {
      final response = await callback(code);

      request.response.headers.contentType = ContentType.text;
      request.response.write(response);
    } else {
      request.response.statusCode = HttpStatus.badRequest;
    }

    await request.response.close();
  }
}
