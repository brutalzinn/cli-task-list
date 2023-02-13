import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/commands/repo/add_repo.dart';
import 'package:auto_assistant_cli/commands/repo/del_repo.dart';
import 'package:auto_assistant_cli/commands/repo/list_repo.dart';

class RepoCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  final name = "repo";
  final description = "Repo manager";

  RepoCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    addSubcommand(AddRepoCommand());
    addSubcommand(DelRepoCommand());
    addSubcommand(ListRepoCommand());
  }

  void run() {}
}
