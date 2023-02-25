// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class ListTaskCommand extends Command {
  @override
  final name = "list";
  @override
  final description = "list tasks of current repo";

  ListTaskCommand();

  @override
  void run() async {
    Config.cacheManager.refresh();
    final currentCache = Config.cacheManager.cache;
    final currentRepo =
        RepoManager.load(currentCache?.currentRepo.fileName ?? "default");
    final tasks = currentCache?.tasks ?? [];
    tasks.addAll(currentRepo.tasks);
    for (int i = 0; i < tasks.length; i++) {
      final item = tasks[i];
      ConsoleWritter.write(
          "[${i}] ${item.name} Create at ${item.createAt} Last Update: ${item.updateAt}");
    }
  }
}
