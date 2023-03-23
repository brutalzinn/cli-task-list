// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/access_token.dart';
import 'package:auto_assistant_cli/models/task.dart';
import 'package:auto_assistant_cli/utils/authentication_util.dart';
import 'package:http/http.dart' as httpClient;
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/repo.dart';

class HttpConnector {
  late HttpClient client;
  String baseURL;
  String basicAuth;
  String? baererAuth;
  HttpConnector(
    this.baseURL,
    this.basicAuth,
  ) {
    client = HttpClient();
  }

  Future<List<Repo>> getRepos(int page) async {
    final request = await client.getUrl(
        Uri.parse("$baseURL/repo/paginate?page=$page&limit=5&order=DESC"));
    //request.headers.add("x-api-key", apiKey);
    final response = await request.close();
    final contentAsString = await utf8.decodeStream(response);
    if (response.statusCode == 401) {
      ConsoleWritter.writeError(contentAsString);
      client.close(force: true);
      return List<Repo>.empty();
    }
    final map = json.decode(contentAsString);
    return (map['data']['repos'] as List)
        .map((repo) => Repo.fromMap(repo))
        .toList();
  }

  ///wrong way to do this.
  Future<AccessToken> authorization(String code) async {
    ConsoleWritter.writeWarning(basicAuth);
    final Uri uri = Uri.parse(Config.oAuthTokenServerUrl);
    final body = {
      "grant_type": "authorization_code",
      "code": code,
      "redirect_uri": Config.oAuthRedirectURL
    };
    final headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": basicAuth
    };
    final response = await httpClient.post(uri, body: body, headers: headers);
    final accessToken = AccessToken.fromJson(response.body);
    if (response.statusCode == 200) {
      return accessToken;
    } else {
      throw Exception(
          'Failed to send multipart request: ${response.statusCode}');
    }
  }

  ///wrong way to do this.
  Future<AccessToken> refreshToken(String refreshToken) async {
    ConsoleWritter.writeWarning(basicAuth);
    final Uri uri = Uri.parse(Config.oAuthTokenServerUrl);
    final body = {"grant_type": "refresh_token", "refresh_token": refreshToken};
    final headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": basicAuth
    };
    final response = await httpClient.post(uri, body: body, headers: headers);
    final accessToken = AccessToken.fromJson(response.body);
    if (response.statusCode == 200) {
      return accessToken;
    } else {
      throw Exception(
          'Failed to send multipart request: ${response.statusCode}');
    }
  }

  Future<void> pushTask(String remote, List<Task> tasks) async {
    final headers = {
      "Content-Type": "application/json",
      "Authorization": baererAuth
    };
    final request = await client.postUrl(Uri.parse(remote));
    request.headers.contentLength = tasks.length;
    request.write(tasks);
  }
}
