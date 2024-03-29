import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/models/task.dart';
import 'package:auto_assistant_cli/repo_manager.dart';
import 'package:auto_assistant_cli/utils/external_editor.dart';

class AddTaskCommand extends Command {
  @override
  final name = "add";
  @override
  final description = "add a task";

  AddTaskCommand();

  @override
  void run() {
    var taskName = argResults?.arguments[0] ?? "";
    var taskDescription = "";
    if (argResults?.arguments.length == 2) {
      taskDescription = argResults?.arguments[1] ?? "";
    }
    final task = Task(taskName, taskDescription, "");
    Config.cacheManager.refresh();
    Config.cacheManager.cache!.tasks.add(task);
    Config.cacheManager.save();
    ConsoleWritter.writeWithColor("Task \"$taskName\" created", Colors.green);
  }
}
