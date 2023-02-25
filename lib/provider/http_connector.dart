// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:auto_assistant_cli/models/repo.dart';

class HttpConnector {
  late HttpClient client;
  String baseURL;
  String apiKey;
  HttpConnector(
    this.baseURL,
    this.apiKey,
  ) {
    client = HttpClient();
  }

  Future<List<Repo>> getRepos(int page) async {
    final request = await client.getUrl(
        Uri.parse("$baseURL/repo/paginate?page=$page&limit=5&order=DESC"));
    request.headers.add("x-api-key", apiKey);
    final response = await request.close();
    final contentAsString = await utf8.decodeStream(response);
    final map = json.decode(contentAsString);
    return (map['data']['repos'] as List)
        .map((repo) => Repo.fromMap(repo))
        .toList();
  }
}
