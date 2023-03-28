import 'dart:async';
import 'dart:convert';
import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/access_token.dart';
import 'package:auto_assistant_cli/http/http_client.dart';
import 'package:auto_assistant_cli/common/oauth_authorize.dart';
import 'package:auto_assistant_cli/utils/authentication_util.dart';
import 'package:auto_assistant_cli/utils/external_browser.dart';
import 'package:auto_assistant_cli/utils/oauth_code_handler.dart';

class AuthRemote extends Command {
  @override
  final name = "auth";
  @override
  final description = "auth with oauth2 remote provider";

  AuthRemote();

  @override
  void run() async {
    final acessToken = await OAuthAuthenticator.auth();
    saveToken(acessToken);
  }

  static void saveToken(AccessToken accessToken) {
    Config.cacheManager.refresh();
    Config.cacheManager.cache?.accessToken = accessToken.accessToken;
    Config.cacheManager.cache?.refreshToken = accessToken.refreshToken;
    Config.cacheManager.save();
  }
}
