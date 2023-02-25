import 'package:args/command_runner.dart';
import 'remote/push_remote.dart';

class RemoteCommand extends Command {
  @override
  final name = "remote";
  @override
  final description = "Remote manager with api-task-list";

  RemoteCommand() {
    addSubcommand(PushRemoteCommand());
  }
}
