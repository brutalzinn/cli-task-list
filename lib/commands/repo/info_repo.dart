import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/storage_manager.dart';

class InfoRepoCommand extends Command {
  @override
  final name = "info";
  @override
  final description = "info of repo";

  InfoRepoCommand();

  @override
  void run() {
    final currentRepo = Config.cacheManager.cache.currentRepo;
    final info = StorageManager.load(currentRepo);
    print(
        "Name ${info.repo} ${info.repo.createAt} ${info.repo.updateAt} tasks: ${info.tasks.length}");
  }
}