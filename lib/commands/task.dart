import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/commands/task/add_task.dart';
import 'package:auto_assistant_cli/commands/task/list_task.dart';

class TaskCommand extends Command {
  @override
  final name = "task";
  @override
  final description = "Task manager";

  TaskCommand() {
    addSubcommand(AddTaskCommand());
    addSubcommand(ListTaskCommand());
  }
}
