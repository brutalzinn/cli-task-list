import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/provider/http_connector.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class AddRemoteUrl extends Command {
  @override
  final name = "url";
  @override
  final description = "change remote url";

  AddRemoteUrl();

  @override
  void run() {
    final apiUrl = argResults?.arguments[0] ?? "";
    Config.cacheManager.refresh();
    final currentCache = Config.cacheManager.cache;
    currentCache!.apiUrl = apiUrl;
    Config.cacheManager.save();
    ConsoleWritter.writeWithColor("Api url is $apiUrl", Colors.green);
  }
}
