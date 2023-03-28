// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/repo_manager.dart';
import 'package:auto_assistant_cli/utils/external_editor.dart';

class EditTaskCommand extends Command {
  @override
  final name = "edit";
  @override
  final description = "edit task";

  EditTaskCommand();

  @override
  void run() async {
    var index = int.tryParse(argResults!.arguments[0]) ?? 0;
    Config.cacheManager.refresh();
    final task = Config.cacheManager.cache!.tasks[index];
    if (task.text.isNotEmpty) {
      await ExternalEditor.writeTmpFile(task.text);
    }
    final content = await ExternalEditor.showDefaultEditor();
    task.text = content;
    Config.cacheManager.save();
    ConsoleWritter.writeWithColor("Task ${task.title} created", Colors.green);
  }
}
