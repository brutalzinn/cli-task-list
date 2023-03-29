import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class CommitCommand extends Command {
  @override
  final name = "commit";
  @override
  final description = "move cache to repos";

  CommitCommand();

  @override
  void run() {
    Config.cacheManager.refresh();
    final currentCache = Config.cacheManager.cache;
    final currentRepo = currentCache!.currentRepo;
    final currentRepoFilename = currentRepo.fileName;
    final info = RepoManager.load(currentRepoFilename);
    info.repo.updateAt = DateTime.now();
    info.tasks.addAll(currentCache.tasks);
    info.save();
    Config.cacheManager.cache!.tasks.clear();
    Config.cacheManager.save();
    ConsoleWritter.writeWithColor("Saved", Colors.green);
    ConsoleWritter.writeWithColor("Local cache cleaned", Colors.yellow);
  }
}
