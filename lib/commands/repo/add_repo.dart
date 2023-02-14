import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/storage_manager.dart';

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
    final repo = Repo(repoName, repoDescription, currentDate, currentDate);
    final storageManager = StorageManager(repo: repo, tasks: []);
    storageManager.save();
    print(repoName);
  }
}