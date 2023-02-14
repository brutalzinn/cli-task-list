import 'package:args/command_runner.dart';

class DelRepoCommand extends Command {
  @override
  final name = "del";
  @override
  final description = "del a repo";

  DelRepoCommand();
  @override
  void run() {
    print(argResults!['del']);
  }
}
