import 'dart:io';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:path/path.dart';

import 'package:args/command_runner.dart';

import '../../config.dart';

class DelRepoCommand extends Command {
  @override
  final name = "del";
  @override
  final description = "del a repo";

  DelRepoCommand();
  @override
  void run() async {
    var index = int.tryParse(argResults!.arguments[0]) ?? 0;
    final repoDirectory = Directory(Config.repoDirectory);
    final files =
        await repoDirectory.list(recursive: false, followLinks: false).toList();

    for (int i = 0; i < files.length; i++) {
      final item = files[i];
      final filename = basename(item.path).replaceAll(".json", "");
      if (i == index) {
        File(item.path).delete();
        ConsoleWritter.writeWithColor("DELETED $filename", Colors.green);
        break;
      }
    }
  }
}
