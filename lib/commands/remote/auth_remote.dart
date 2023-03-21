import 'dart:async';
import 'dart:convert';
import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
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
    final authorizationEndpoint =
        "${Config.oAuthAuthorizeServerUrl}?response_type=code&client_id=$identifier&client_secret=$secret&scope=read%3Arepo%20create%3Arepo&redirect_uri=$redirectUrl";
    await openBrowser(authorizationEndpoint);
    OAuthUtil.waitCodeOAuth(
      (code) async {
        ConsoleWritter.writeImportant("code $code");
        final authorization = await OAuthUtil.authorization(code);
        ConsoleWritter.write("ACCESS TOKEN: ${authorization.toJson()}");
        final refreshToken =
            await OAuthUtil.refreshToken(authorization.accessToken);
        ConsoleWritter.write(
            "REFRESH ACCESS TOKEN: ${refreshToken.accessToken}");
        ConsoleWritter.write(
            "REFRESH ACCESS TOKEN EXPIRE AT: ${refreshToken.expiresIn}");
      },
    );
  }

  Future openBrowser(String authorizationEndpoint) async {
    ExternalBrowser.runBrowser(Uri.decodeFull(authorizationEndpoint));
  }
}
