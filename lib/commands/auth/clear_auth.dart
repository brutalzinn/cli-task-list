import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class ClearAuthCommand extends Command {
  @override
  final name = "clear";
  @override
  final description = "clear a auth";

  ClearAuthCommand();

  @override
  void run() {
    Config.cacheManager.refresh();
    final currentCache = Config.cacheManager.cache;
    currentCache!.apiKey = null;
    Config.cacheManager.save();
  }
}
