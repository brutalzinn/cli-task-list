import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class ConfigCommand extends Command {
  @override
  final name = "config";
  @override
  final description = "config default env";

  ConfigCommand();

  @override
  void run() {
    Config.cacheManager.refresh();
    var configName = argResults?.arguments[0] ?? "";
    final currentCache = Config.cacheManager.cache;
    currentCache?.defaultEditorPath = configName;
    Config.cacheManager.save();
    ConsoleWritter.writeWithColor("Config saved", Colors.yellow);
  }
}
