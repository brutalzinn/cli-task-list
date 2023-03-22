// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/provider/http_connector.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

///DEPRECATED

class ListRemoteCommand extends Command {
  @override
  final name = "list";
  @override
  final description = "list repos";

  ListRemoteCommand() {
    argParser.addOption('page', abbr: 'p', defaultsTo: '1');
  }

  @override
  void run() {
    Config.cacheManager.refresh();
    final cacheManager = Config.cacheManager.cache;
    final currentRepo = cacheManager?.currentRepo;
    final currentRemote = currentRepo?.remotes ?? [];
    if (currentRemote.isEmpty) {
      ConsoleWritter.writeWarning(
          "No remotes found for repo ${currentRepo?.title}");
      return;
    }
    for (int i = 0; i < currentRemote.length; i++) {
      final item = currentRemote[i];
      ConsoleWritter.write("[${i}] Remote: ${item.name} url: ${item.url}");
    }
  }
}
