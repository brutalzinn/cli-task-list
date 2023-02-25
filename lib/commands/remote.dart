import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/commands/remote/add_remote_url.dart';
import 'package:auto_assistant_cli/commands/remote/list_remote.dart';
import 'remote/push_remote.dart';

class RemoteCommand extends Command {
  @override
  final name = "remote";
  @override
  final description = "Remote manager with api-task-list";

  RemoteCommand() {
    // addSubcommand(PushRemoteCommand());
    addSubcommand(AddRemoteUrl());
    addSubcommand(ListRemoteCommand());
  }
}
