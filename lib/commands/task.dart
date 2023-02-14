import 'package:args/command_runner.dart';

class TaskCommand extends Command {
  @override
  final name = "task";
  @override
  final description = "Task manager";

  TaskCommand();

  @override
  void run() {}
}
