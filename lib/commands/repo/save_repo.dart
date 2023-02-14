import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/config.dart';

class SaveRepoCommand extends Command {
  @override
  final name = "save";
  @override
  final description = "Save repo";

  SaveRepoCommand();

  @override
  void run() {
    Config.cacheManager.save();
    print("Saved");
  }
}
