import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
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
      ConsoleWritter.writeWithColor("repo not found", Colors.red);
      return;
    }
    Config.cacheManager.cache!.currentRepo.name = repoName;
    Config.cacheManager.save();
    ConsoleWritter.write("Current repo changed to $repoName");
  }
}
