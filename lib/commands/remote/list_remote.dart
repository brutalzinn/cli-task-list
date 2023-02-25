// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/provider/http_connector.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class ListRemoteCommand extends Command {
  @override
  final name = "list";
  @override
  final description = "list repos";

  ListRemoteCommand() {
    argParser.addOption('page', abbr: 'p', defaultsTo: '1');
  }

  @override
  void run() async {
    final page = int.parse(argResults!['page']);
    ConsoleWritter.writeWithColor("Show repos of page $page", Colors.yellow);
    Config.cacheManager.refresh();
    final cacheManager = Config.cacheManager.cache;
    final apiKey = cacheManager?.apiKey ?? "";
    final apiUrl = cacheManager?.apiUrl ?? "";

    if (apiKey.isEmpty || apiUrl.isEmpty) {
      ConsoleWritter.writeWithColor("WARNING!", Colors.yellow);
      ConsoleWritter.writeWithColor("Register a api key first.", Colors.red);
      return;
    }
    ConsoleWritter.writeWithColor(
        "prepare to get remote list...", Colors.yellow);
    var httpConnector = HttpConnector(apiUrl, apiKey);
    final repos = await httpConnector.getRepos(page);
    ConsoleWritter.write("data: ${repos} ");
  }
}
