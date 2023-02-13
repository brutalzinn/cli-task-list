import 'package:args/command_runner.dart';

class TaskCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  final name = "task";
  final description = "Task manager";

  TaskCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    //argParser.addFlag('all', abbr: 'a');
  }

  void run() {}
}
