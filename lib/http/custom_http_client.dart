// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/common/oauth_authenticator.dart';
import 'package:auto_assistant_cli/http/oauth_interceptor.dart';
import 'package:auto_assistant_cli/models/access_token.dart';
import 'package:auto_assistant_cli/models/remote.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/models/task.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:dio/dio.dart';

//after week we can refactor this calling the concept of only instance one httpConnector and handle if request needs api key or is only user auth request.

class CustomHttpClient {
  late Dio dio;
  String? baererAuth;
  CustomHttpClient({this.baererAuth}) {
    dio = Dio();
    dio.options
      ..baseUrl = Config.apiBaseUrl
      ..connectTimeout = Duration(seconds: 5)
      ..receiveTimeout = Duration(seconds: 5)
      ..headers = {"Authorization": baererAuth};
    dio.interceptors.add(OuthInterceptor());
  }

  setBaererAuth(String baererAuth) {
    this.baererAuth = baererAuth;
  }

  Future<List<Repo>> getRepos(int page) async {
    Response response =
        await dio.get("/repo/paginate?page=$page&limit=5&order=DESC");
    if (response.statusCode == 200) {
      ConsoleWritter.writeWithColor("Push with success", Colors.green);
      ConsoleWritter.writeWithColor("Page: $page", Colors.green);

      final map = json.decode(response.data);
      return (map['data']['repos'] as List)
          .map((repo) => Repo.fromMap(repo))
          .toList();
    } else {
      throw Exception('Failed to send new tasks: ${response.statusCode}');
    }
  }

  ///wrong way to do this.
  Future<AccessToken?> authorization(String code, String basicAuth) async {
    final body = {
      "grant_type": "authorization_code",
      "code": code,
      "redirect_uri": Config.oAuthRedirectURL
    };
    final response = await dio.post(
      Config.oAuthTokenServerUrl,
      data: body,
      options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": basicAuth}),
    );
    if (response.statusCode == 200) {
      final accessToken = AccessToken.fromMap(response.data);
      return accessToken;
    }
    return null;
  }

  ///wrong way to do this.
  Future<AccessToken?> refreshToken(
      String refreshToken, String basicAuth) async {
    final body = {"grant_type": "refresh_token", "refresh_token": refreshToken};
    final response = await dio.post(
      Config.oAuthTokenServerUrl,
      data: body,
      options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": basicAuth}),
    );
    if (response.statusCode == 200) {
      final accessToken = AccessToken.fromMap(response.data);
      return accessToken;
    }
    return null;
  }

  Future<void> pushTask(Remote remote, List<Task> tasks) async {
    final body = tasks.map((x) => x.toMap()).toList();
    final response = await dio.put(remote.url, data: body);
    if (response.statusCode == 200) {
      ConsoleWritter.writeWithColor("Push with success", Colors.green);
    } else {
      throw Exception('Failed to send new tasks: ${response.statusCode}');
    }
  }
}
