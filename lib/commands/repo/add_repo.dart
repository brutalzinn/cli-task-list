import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class AddRepoCommand extends Command {
  @override
  final name = "add";
  @override
  final description = "add a repo";

  AddRepoCommand();

  @override
  void run() {
    var repoName = argResults?.arguments[0] ?? "";
    var repoDescription = "";
    if (argResults?.arguments.length == 2) {
      repoDescription = argResults?.arguments[1] ?? "";
    }
    final currentDate = DateTime.now();
    final fileName = repoName.replaceAll(" ", "-").toLowerCase();
    final repo = Repo(repoName, repoDescription,
        remotes: [], fileName: fileName, createAt: currentDate);
    final storageManager = RepoManager(repo: repo, tasks: []);
    storageManager.save();
    ConsoleWritter.writeWithColor(
        "$repoName added with success.", Colors.green);
  }
}
