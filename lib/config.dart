import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/models/cache.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:intl/intl.dart';

class Config {
  static const String defaultEditor =
      "C://Program Files//Notepad++//notepad++.exe";
  static const String repoDirectory = "repos";
  static const String cacheDirectory = "cache";
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  static CacheManager cacheManager = CacheManager(
      cache: Cache(currentRepo: Repo("default", ""), remotes: [], tasks: []));

  static const String oAuthRedirectURL = String.fromEnvironment(
      "OAUTH_REDIRECT_URL",
      defaultValue: "http://localhost:8888");

  static const String oAuthAuthorizeServerUrl = String.fromEnvironment(
      "OAUTH_AUTHORIZE_URL",
      defaultValue: "http://localhost:9000/oauth/authorize");

  static const String oAuthTokenServerUrl = String.fromEnvironment(
      "OAUTH_TOKEN_URL",
      defaultValue: "http://localhost:9000/oauth/token");

  static const String clientId = String.fromEnvironment("CLIENT_ID",
      defaultValue: "e6fe1346-2cf3-4906-99de-b1e8219d8008");

  static const String clientSecret = String.fromEnvironment("CLIENT_SECRET",
      defaultValue: "6086ef00-a0d7-4d57-9ca5-e47b01793d5a");
}
