import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class SaveRepoCommand extends Command {
  @override
  final name = "save";
  @override
  final description = "Save repo";

  SaveRepoCommand();

  @override
  void run() {
    Config.cacheManager.refresh();
    final currentCache = Config.cacheManager.cache;
    final currentRepo = currentCache!.currentRepo;
    final currentRepoFilename = currentRepo.fileName;
    final info = RepoManager.load(currentRepoFilename);
    info.repo.updateAt = DateTime.now();
    info.tasks.addAll(currentCache.tasks);
    Config.cacheManager.cache!.tasks.clear();
    info.save();
    Config.cacheManager.save();
    print("Saved");
    print("Local cache cleaned");
  }
}
