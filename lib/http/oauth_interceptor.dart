import 'package:auto_assistant_cli/common/oauth_authenticator.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/utils/authentication_header_util.dart';
import 'package:dio/dio.dart';

class OuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    ConsoleWritter.writeError("Something does wrong way..");
    if (err.response?.statusCode == 401) {
      // if (Config.cacheManager.cache?.accessToken != null &&
      //     Config.cacheManager.cache?.refreshToken != null) {
      //   final data = await OAuthAuthenticator.refreshToken(
      //       Config.cacheManager.cache?.refreshToken ?? "");
      //   if (data == null) {
      //     return;
      //   }
      //   Config.cacheManager.cache!.accessToken = data.accessToken;
      //   Config.cacheManager.cache!.refreshToken = data.refreshToken;
      //   ConsoleWritter.writeOK("Refreshing token..");
      //   super.onError(err, handler);
      // }
      await OAuthAuthenticator.auth();
    }
    super.onError(err, handler);
  }
}
