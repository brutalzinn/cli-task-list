import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/commands/AuthCommand.dart';
import 'package:auto_assistant_cli/commands/RepoCommand.dart';
import 'package:auto_assistant_cli/commands/TaskCommand.dart';

void main(List<String> args) {
  var runner = CommandRunner(
      "dgit", "A dart implementation of distributed version control.")
    ..addCommand(TaskCommand())
    ..addCommand(RepoCommand())
    ..addCommand(AuthCommand())
    ..run(args);
}
