// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/models/access_token.dart';
import 'package:auto_assistant_cli/models/task.dart';
import 'package:auto_assistant_cli/utils/authentication_util.dart';
import 'package:http/http.dart' as httpClient;
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/repo.dart';

class HttpConnector {
  String baseURL;
  String basicAuth;
  String? baererAuth;
  HttpConnector(
    this.baseURL,
    this.basicAuth,
  );

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
      "Authorization": basicAuth
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
      "Authorization": basicAuth
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

  Future<void> pushTask(String remote, List<Task> tasks) async {
    final Uri uri = Uri.parse(Config.oAuthTokenServerUrl);
    final headers = {
      "Content-Type": "application/json",
      "Authorization": baererAuth ?? ""
    };
    final body = tasks.map((x) => x.toMap()).toList();
    final response = await httpClient.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      ConsoleWritter.writeWithColor("Push with success", Colors.green);
    } else {
      throw Exception(
          'Failed to send multipart request: ${response.statusCode}');
    }
  }
}
