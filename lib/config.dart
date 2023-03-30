import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/http/custom_http_client.dart';
import 'package:auto_assistant_cli/models/cache.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:intl/intl.dart';

class Config {
  static const String repoDirectory = "repos";
  static const String cacheDirectory = "cache";
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  static CacheManager cacheManager = CacheManager(
      cache: Cache(currentRepo: Repo("default", "", remotes: []), tasks: []));

  static CustomHttpClient customHttpClient = CustomHttpClient();

  static const String apiBaseUrl = String.fromEnvironment("API_BASE_URL",
      defaultValue: "http://localhost:9000");

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
      defaultValue: "d45bc6bd-a066-482e-8b64-b56a34d9b2ba");

  static const String clientSecret = String.fromEnvironment("CLIENT_SECRET",
      defaultValue: "434977f5-2dc8-4290-bec5-e4a14e629d37");
}
