import 'dart:async';
import 'dart:convert';
import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/provider/http_connector.dart';
import 'package:auto_assistant_cli/utils/authentication_util.dart';
import 'package:auto_assistant_cli/utils/external_browser.dart';
import 'package:auto_assistant_cli/utils/oauth_util.dart';

class AuthRemote extends Command {
  final identifier = Config.clientId;
  final secret = Config.clientSecret;
  final redirectUrl = Config.oAuthRedirectURL;

  @override
  final name = "auth";
  @override
  final description = "auth with oauth2 remote provider";

  AuthRemote();

  @override
  void run() async {
    Config.cacheManager.refresh();
    final basicAuth = AuthenticationUtil.basicAuth(identifier, secret);
    final httpConnector = HttpConnector(Config.apiBaseUrl, basicAuth);
    await openAuthRequest();
    OAuthUtil.waitCodeOAuth(
      (code) async {
        ConsoleWritter.writeWarning("code $code");
        final authorization = await httpConnector.authorization(code);
        ConsoleWritter.write("ACCESS TOKEN: ${authorization.toJson()}");
        final refreshToken =
            await httpConnector.refreshToken(authorization.accessToken);
        ConsoleWritter.write(
            "REFRESH ACCESS TOKEN: ${refreshToken.accessToken}");
        ConsoleWritter.write(
            "REFRESH ACCESS TOKEN EXPIRE AT: ${refreshToken.expiresIn}");
      },
    );
  }

  Future openAuthRequest() async {
    final authorizationEndpoint =
        "${Config.oAuthAuthorizeServerUrl}?response_type=code&client_id=$identifier&client_secret=$secret&scope=read%3Arepo%20create%3Arepo&redirect_uri=$redirectUrl";
    ExternalBrowser.runBrowser(Uri.decodeFull(authorizationEndpoint));
  }
}
