import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/access_token.dart';
import 'package:auto_assistant_cli/http/http_client.dart';
import 'package:auto_assistant_cli/utils/authentication_util.dart';
import 'package:auto_assistant_cli/utils/external_browser.dart';
import 'package:auto_assistant_cli/utils/oauth_code_handler.dart';

class OAuthAuthenticator {
  static String identifier = Config.clientId;
  static String secret = Config.clientSecret;
  static String redirectUrl = Config.oAuthRedirectURL;

  static Future<AccessToken> auth() async {
    final basicAuth = AuthenticationUtil.basicAuth(identifier, secret);
    final httpConnector = HttpClient(basicAuth: basicAuth);
    ConsoleWritter.write("Trying to open your default browser..");
    await _openAuthRequest();
    String receivedCode = "";
    await OAuthCodeHandler.waitCodeOAuth((code) {
      ConsoleWritter.write("Request authorization with code $code");
      receivedCode = code;
    });
    ConsoleWritter.writeOK("Authenticated with success");
    final acessToken = await httpConnector.authorization(receivedCode);
    return acessToken;
  }

  static Future<AccessToken> refreshToken([String? refreshToken]) async {
    final basicAuth = AuthenticationUtil.basicAuth(identifier, secret);
    final httpConnector = HttpClient(basicAuth: basicAuth);
    ConsoleWritter.write("Retriving authentication by code");
    final acessToken = await httpConnector
        .refreshToken(Config.cacheManager.cache?.refreshToken ?? "");
    return acessToken;
  }

  static Future _openAuthRequest() async {
    final authorizationEndpoint =
        "${Config.oAuthAuthorizeServerUrl}?response_type=code&client_id=$identifier&client_secret=$secret&scope=read%3Arepo%20create%3Arepo&redirect_uri=$redirectUrl";
    ExternalBrowser.runBrowser(Uri.decodeFull(authorizationEndpoint));
  }
}
