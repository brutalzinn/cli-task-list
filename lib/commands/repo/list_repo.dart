import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:path/path.dart';

class ListRepoCommand extends Command {
  @override
  final name = "list";
  @override
  final description = "list repos";

  ListRepoCommand();

  @override
  void run() async {
    final repoDirectory = Directory(Config.repoDirectory);
    final files =
        await repoDirectory.list(recursive: false, followLinks: false).toList();

    for (int i = 0; i < files.length; i++) {
      final item = files[i];
      final filename = basename(item.path).replaceAll(".json", "");
      ConsoleWritter.write("[${i}] ${filename}");
    }
  }
}
