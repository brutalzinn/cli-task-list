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
    var name = "origin";
    Config.cacheManager.refresh();
    final currentCache = Config.cacheManager.cache;
    final remotes = currentCache?.remotes ?? [];
    final remote = remotes.firstWhere((element) => element.name == name);
    final authorizationEndpoint =
        "${remote.url}/oauth/authorize?response_type=code&client_id=$identifier&client_secret=$secret&scope=read%3Arepo%20create%3Arepo&redirect_uri=$redirectUrl";
    print(authorizationEndpoint);
    // final tokenEndpoint = Uri.parse("${remote.url}/oauth/token");
    await openBrowser(authorizationEndpoint);
    final code = await OAuthUtil.listenCallback();
    final getAuthorization = await OAuthUtil.getAuthorization(code);
    ConsoleWritter.write("Token received: ${getAuthorization.accessToken}");
  }

  Future openBrowser(String authorizationEndpoint) async {
    ExternalBrowser.runBrowser(Uri.decodeFull(authorizationEndpoint));
  }
}
