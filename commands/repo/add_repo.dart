import 'package:args/command_runner.dart';

class AddRepoCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  final name = "add";
  final description = "add a repo";

  AddRepoCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
  }

  // [run] may also return a Future.
  void run() {
    // [argResults] is set before [run()] is called and contains the flags/options
    // passed to this command.
    print(argResults!['add']);
  }
}
