import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/commands/remote.dart';
import 'package:auto_assistant_cli/commands/repo.dart';
import 'package:auto_assistant_cli/commands/task.dart';
import 'package:auto_assistant_cli/commands/auth.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

void main(List<String> args) {
  CacheManager.initialize();
  RepoManager.initialize();
  CommandRunner("note", "A task implementation to uses with api-task-list")
    ..addCommand(TaskCommand())
    ..addCommand(RepoCommand())
    ..addCommand(RemoteCommand())
    ..run(args);
}
