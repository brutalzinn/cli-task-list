import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/commands/repo/add_repo.dart';
import 'package:auto_assistant_cli/commands/repo/del_repo.dart';
import 'package:auto_assistant_cli/commands/repo/info_repo.dart';
import 'package:auto_assistant_cli/commands/repo/list_repo.dart';
import 'package:auto_assistant_cli/commands/repo/select_repo.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class RepoCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  @override
  final name = "repo";
  @override
  final description = "Repo manager";

  RepoCommand() {
    addSubcommand(AddRepoCommand());
    addSubcommand(DelRepoCommand());
    addSubcommand(ListRepoCommand());
    addSubcommand(SelectRepoCommand());
    addSubcommand(InfoRepoCommand());
  }
}
