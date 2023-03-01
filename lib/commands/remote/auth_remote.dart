import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/remote.dart';
import 'package:auto_assistant_cli/provider/http_connector.dart';
import 'package:auto_assistant_cli/repo_manager.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class AuthRemote extends Command {
  @override
  final name = "auth";
  @override
  final description = "auth with oauth2 remote provider";

  AuthRemote();

  @override
  void run() async {
    var name = argResults?.arguments[0] ?? "";
    Config.cacheManager.refresh();
    final currentCache = Config.cacheManager.cache;
    final remotes = currentCache?.remotes ?? [];
    final remote = remotes.firstWhere((element) => element.name == name);
    final authorizationEndpoint = Uri.parse("${remote.url}/oauth/authorize");
    final tokenEndpoint = Uri.parse("${remote.url}/oauth/token");
    final redirectUrl = Uri.parse('http://localhost:8080');

    const identifier = '222222';
    const secret = '22222222';

    // final credentialsFile = File('credentials.json');
    // var exists = await credentialsFile.exists();

    // if (exists) {
    //   var credentials =
    //       oauth2.Credentials.fromJson(await credentialsFile.readAsString());
    //   oauth2.Client(credentials, identifier: identifier, secret: secret);
    // }
    // If we don't have OAuth2 credentials yet, we need to get the resource owner
    // to authorize us. We're assuming here that we're a command-line application.
    var grant = oauth2.AuthorizationCodeGrant(
        identifier, authorizationEndpoint, tokenEndpoint,
        secret: secret);

    // A URL on the authorization server (authorizationEndpoint with some
    // additional query parameters). Scopes and state can optionally be passed
    // into this method.
    var authorizationUrl = grant.getAuthorizationUrl(redirectUrl);

    // Redirect the resource owner to the authorization URL. Once the resource
    // owner has authorized, they'll be redirected to `redirectUrl` with an
    // authorization code. The `redirect` should cause the browser to redirect to
    // another URL which should also have a listener.
    //
    // `redirect` and `listen` are not shown implemented here.
    await redirect(authorizationUrl);
    var responseUrl = await listen(redirectUrl);

    // Once the user is redirected to `redirectUrl`, pass the query parameters to
    // the AuthorizationCodeGrant. It will validate them and extract the
    // authorization code to create a new Client.
    grant.handleAuthorizationResponse(responseUrl.queryParameters);
  }

  Future<void> redirect(Uri url) async {
    // Client implementation detail
  }

  Future<Uri> listen(Uri url) async {
    // Client implementation detail
    return Uri();
  }
}
