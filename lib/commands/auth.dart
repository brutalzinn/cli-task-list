import 'package:args/command_runner.dart';

class AuthCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  @override
  final name = "auth";
  @override
  final description = "Authentication manager with api-task-list";

  AuthCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    argParser.addOption('add', abbr: 'a');
    argParser.addOption('clear', abbr: 'c');
  }

  // [run] may also return a Future.
  @override
  void run() {
    // [argResults] is set before [run()] is called and contains the flags/options
    // passed to this command.
    print(argResults!['add']);
  }
}
