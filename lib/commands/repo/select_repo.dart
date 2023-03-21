import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/repo_manager.dart';
import 'package:path/path.dart' as Path;

class SelectRepoCommand extends Command {
  @override
  final name = "select";
  @override
  final description = "select repo";

  SelectRepoCommand();

  ///SLOW DOWN. HIPERFOCUS IS DETECTED HERE. 20/03/2023T22:00:35
  @override
  void run() async {
    var index = int.tryParse(argResults!.arguments[0]) ?? 0;
    final repos = Directory(Config.repoDirectory);
    final files =
        await repos.list(recursive: false, followLinks: false).toList();
    final fileName = Path.basename(files[index].path).replaceAll(".json", "");
    final repoDirectory =
        File(Path.join(Config.repoDirectory, "$fileName.json"));
    final repoExists = repoDirectory.existsSync();
    if (repoExists == false) {
      ConsoleWritter.writeWithColor("repo not found", Colors.red);
      return;
    }
    final currentRepo = RepoManager.load(fileName);
    Config.cacheManager.cache!.currentRepo = currentRepo.repo;
    Config.cacheManager.save();
    ConsoleWritter.write(
        "Current repo changed to \"${currentRepo.repo.title}\"");
  }
}
