// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/models/access_token.dart';
import 'package:auto_assistant_cli/models/remote.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/models/task.dart';
import 'package:http/http.dart' as httpClient;
import 'package:auto_assistant_cli/console/console_writter.dart';

//after week we can refactor this calling the concept of only instance one httpConnector and handle if request needs api key or is only user auth request.

class HttpConnector {
  String baseURL;
  String? basicAuth;
  String? baererAuth;
  HttpConnector(this.baseURL, {this.basicAuth, this.baererAuth});

  Future<List<Repo>> getRepos(int page) async {
    final Uri uri =
        Uri.parse("$baseURL/repo/paginate?page=$page&limit=5&order=DESC");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": baererAuth ?? ""
    };
    final response = await httpClient.get(uri, headers: headers);
    if (response.statusCode == 200) {
      ConsoleWritter.writeWithColor("Push with success", Colors.green);
      final map = json.decode(response.body);
      return (map['data']['repos'] as List)
          .map((repo) => Repo.fromMap(repo))
          .toList();
    } else {
      throw Exception('Failed to send new tasks: ${response.statusCode}');
    }
  }

  ///wrong way to do this.
  Future<AccessToken> authorization(String code) async {
    final Uri uri = Uri.parse(Config.oAuthTokenServerUrl);
    final body = {
      "grant_type": "authorization_code",
      "code": code,
      "redirect_uri": Config.oAuthRedirectURL
    };
    final headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": basicAuth ?? ""
    };
    final response = await httpClient.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      final accessToken = AccessToken.fromJson(response.body);
      return accessToken;
    } else {
      throw Exception(
          'Failed to send authorization multipart request: ${response.statusCode}');
    }
  }

  ///wrong way to do this.
  Future<AccessToken> refreshToken(String refreshToken) async {
    print(refreshToken);
    final Uri uri = Uri.parse(Config.oAuthTokenServerUrl);
    final body = {"grant_type": "refresh_token", "refresh_token": refreshToken};
    final headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": basicAuth ?? ""
    };
    final response = await httpClient.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      final accessToken = AccessToken.fromJson(response.body);
      return accessToken;
    } else {
      throw Exception(
          'Failed to send refreshToken multipart request: ${response.statusCode}');
    }
  }

  Future<void> pushTask(Remote remote, List<Task> tasks) async {
    final Uri uri = Uri.parse(remote.url);
    final headers = {
      "Content-Type": "application/json",
      "Authorization": baererAuth ?? ""
    };
    final body = tasks.map((x) => x.toMap()).toList();
    final response = await httpClient.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      ConsoleWritter.writeWithColor("Push with success", Colors.green);
    } else {
      throw Exception('Failed to send new tasks: ${response.statusCode}');
    }
  }
}
