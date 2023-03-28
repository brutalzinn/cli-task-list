import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/integrations/oauth_authorize.dart';
import 'package:dio/dio.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    if (response.statusCode == 401) {
      OAuthAuthenticator.refreshToken(
              Config.cacheManager.cache?.refreshToken ?? "")
          .then((data) {
        Config.cacheManager.cache!.accessToken = data.accessToken;
        Config.cacheManager.cache!.refreshToken = data.refreshToken;
      });
    }
    super.onResponse(response, handler);
  }
}
