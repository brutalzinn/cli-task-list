import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/commands/remote/add_remote.dart';
import 'package:auto_assistant_cli/commands/remote/auth_remote.dart';
import 'package:auto_assistant_cli/commands/remote/list_remote.dart';
import 'push.dart';

class RemoteCommand extends Command {
  @override
  final name = "remote";
  @override
  final description = "Remote manager with api-task-list";

  RemoteCommand() {
    ///DEPRECATED
    addSubcommand(AddRemote());
    addSubcommand(ListRemoteCommand());
    addSubcommand(AuthRemote());
  }
}
