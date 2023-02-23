import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';

class ListTaskCommand extends Command {
  @override
  final name = "list";
  @override
  final description = "list tasks of current repo";

  ListTaskCommand();

  @override
  void run() async {
    Config.cacheManager.refresh();
    final currentRepo = Config.cacheManager.cache;
    final tasks = currentRepo?.tasks ?? [];
    for (var task in tasks) {
      print(
          "${task.name} Create at ${task.createAt} Last Update: ${task.updateAt}");
    }
  }
}
