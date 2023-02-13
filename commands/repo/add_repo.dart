import 'package:args/command_runner.dart';

class AddRepoCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  final name = "add";
  final description = "add a repo";

  AddRepoCommand() {}

  void run() {
    var repoName = argResults?.arguments ?? "";
  }
}
