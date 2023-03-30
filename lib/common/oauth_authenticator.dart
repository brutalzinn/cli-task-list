import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/access_token.dart';
import 'package:auto_assistant_cli/http/custom_http_client.dart';
import 'package:auto_assistant_cli/utils/authentication_header_util.dart';
import 'package:auto_assistant_cli/utils/external_browser.dart';
import 'package:auto_assistant_cli/utils/oauth_code_handler.dart';

class OAuthAuthenticator {
  static String identifier = Config.clientId;
  static String secret = Config.clientSecret;
  static String redirectUrl = Config.oAuthRedirectURL;

  static Future<AccessToken?> auth() async {
    final basicAuth = AuthenticatorHeaderUtil.basicAuth(identifier, secret);
    ConsoleWritter.write("Trying to open your default browser..");
    await _openAuthRequest();
    String receivedCode = "";
    await OAuthCodeHandler.waitCodeOAuth((code) {
      ConsoleWritter.write("Request authorization with code $code");
      receivedCode = code;
    });
    ConsoleWritter.writeOK("Authenticated with success");
    final acessToken =
        await Config.customHttpClient.authorization(receivedCode, basicAuth);
    if (acessToken != null) {
      _saveToken(acessToken);
      return acessToken;
    }
    return null;
  }

  static Future<AccessToken?> refreshToken(String refreshToken) async {
    final basicAuth = AuthenticatorHeaderUtil.basicAuth(identifier, secret);
    ConsoleWritter.write("Retriving authentication by code");
    final acessToken =
        await Config.customHttpClient.refreshToken(refreshToken, basicAuth);
    if (acessToken != null) {
      _saveToken(acessToken);
      return acessToken;
    }
    return null;
  }

  static Future _openAuthRequest() async {
    final authorizationEndpoint =
        "${Config.oAuthAuthorizeServerUrl}?response_type=code&client_id=$identifier&client_secret=$secret&scope=read%3Arepo%20create%3Arepo&redirect_uri=$redirectUrl";
    ExternalBrowser.runBrowser(Uri.decodeFull(authorizationEndpoint));
  }

  static void _saveToken(AccessToken accessToken) {
    Config.cacheManager.refresh();
    Config.cacheManager.cache?.accessToken = accessToken.accessToken;
    Config.cacheManager.cache?.refreshToken = accessToken.refreshToken;
    Config.cacheManager.save();
  }
}
