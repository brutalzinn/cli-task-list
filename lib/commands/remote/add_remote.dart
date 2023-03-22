import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/remote.dart';
import 'package:auto_assistant_cli/provider/http_connector.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

///DEPRECATED
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
    final remote = Remote(name: name, url: url);
    Config.cacheManager.refresh();
    final currentCache = Config.cacheManager.cache;
    final currentRepo = currentCache?.currentRepo;
    if (currentRepo == null) {
      ConsoleWritter.writeError("Cant found this repo");
      return;
    }
    final currentRemotes = currentCache?.currentRepo.remotes ?? [];
    currentRemotes.add(remote);
    Config.cacheManager.cache?.currentRepo.remotes = currentRemotes;
    Config.cacheManager.save();
    ConsoleWritter.writeWithColor(
        "Remote $name created for repo ${currentRepo.title}", Colors.green);
  }
}
