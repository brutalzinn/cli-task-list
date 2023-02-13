import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/commands/repo.dart';
import 'package:auto_assistant_cli/commands/task.dart';
import 'package:auto_assistant_cli/commands/auth.dart';

void main(List<String> args) {
  var runner =
      CommandRunner("note", "A task implementation to uses with api-task-list")
        ..addCommand(TaskCommand())
        ..addCommand(RepoCommand())
        ..addCommand(AuthCommand())
        ..run(args);
}
