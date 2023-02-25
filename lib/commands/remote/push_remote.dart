import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/provider/http_connector.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class PushRemoteCommand extends Command {
  @override
  final name = "push";
  @override
  final description = "push repo";

  PushRemoteCommand();

  @override
  void run() {
    final cacheManager = Config.cacheManager.cache;
    final apiKey = cacheManager?.apiKey ?? "";
    if (apiKey.isEmpty) {
      ConsoleWritter.writeWithColor("WARNING!", Colors.yellow);
      ConsoleWritter.writeWithColor("Register a api key first.", Colors.red);
      return;
    }
    ConsoleWritter.writeWithColor("prepare to push...", Colors.yellow);
    var httpConnector = HttpConnector(apiKey);
    ConsoleWritter.writeWithColor(
        "data: ${httpConnector.getRepos()} ", Colors.green);
  }
}
