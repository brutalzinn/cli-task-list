import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
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
    for (var entity in files) {
      final filename = basename(entity.path).replaceAll(".json", "");
      print(filename);
    }
  }
}
