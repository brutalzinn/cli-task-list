import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/remote.dart';
import 'package:auto_assistant_cli/provider/http_connector.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class AddRemote extends Command {
  @override
  final name = "add";
  @override
  final description = "add remote provider";

  AddRemote();

  @override
  void run() {
    final name = argResults?.arguments[0] ?? "";
    final url = argResults?.arguments[1] ?? "";
    final remote = Remote(name: name, url: url, apiKey: "");
    Config.cacheManager.refresh();
    final currentCache = Config.cacheManager.cache;
    currentCache!.remotes.add(remote);
    Config.cacheManager.save();
    ConsoleWritter.writeWithColor(
        "Remote $name created. Api url is $url", Colors.green);
  }
}
