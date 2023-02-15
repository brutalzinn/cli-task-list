import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:path/path.dart' as Path;

class SelectRepoCommand extends Command {
  @override
  final name = "select";
  @override
  final description = "select repo";

  SelectRepoCommand();

  @override
  void run() {
    final repoName = argResults?.arguments[0] ?? "";
    final repoDirectory =
        File(Path.join(Config.repoDirectory, "$repoName.json"));
    final repoExists = repoDirectory.existsSync();
    if (repoExists == false) {
      print("repo not found");
      return;
    }
    Config.cacheManager.cache!.currentRepo.name = repoName;
    Config.cacheManager.save();
    print("Current repo changed to $repoName");
  }
}
