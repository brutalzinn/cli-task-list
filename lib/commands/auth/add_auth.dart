import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/models/repo.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class AddAuthCommand extends Command {
  @override
  final name = "add";
  @override
  final description = "add a auth";

  AddAuthCommand();

  @override
  void run() {
    var apiKey = argResults?.arguments[0] ?? "";
    Config.cacheManager.refresh();
    final currentCache = Config.cacheManager.cache;
    currentCache!.apiKey = apiKey;
    Config.cacheManager.save();
  }
}
