import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/access_token.dart';

typedef StringVoidFunc = void Function(String);

class OAuthCodeHandler {
  static Future<void> waitCodeOAuth(StringVoidFunc onReceiveCode) async {
    //what can happen when port 8888 is alredy in use?
    //I think we can implement the a custom http protocol to windows register soo we can get the code again but without socket server.
    //the problem its the complexity. The objective its not recreate wheel. But still dont depend so much of unmanagment package and cross plataform support.
    //to easily do this if i really need this.. i can use oauth/regenerate route to regenerate the oauth credentials to a new callback url
    final server = await HttpServer.bind(InternetAddress.anyIPv4, 8888);
    await for (var request in server) {
      final code = _handleRequest(request);
      if (code != null) {
        onReceiveCode(code);
        request.response.headers.set("content-type", "text/html");
        request.response.write('<h1>You can close this page now.</h1>');
        request.response.close();
        server.close();
      }
    }
  }

  static String? _handleRequest(HttpRequest request) {
    final code = request.uri.queryParameters['code'];
    return code;
  }
}
