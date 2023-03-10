// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/provider/http_connector.dart';
import 'package:auto_assistant_cli/repo_manager.dart';

class PushRemoteCommand extends Command {
  @override
  final name = "push";
  @override
  final description = "push repo";

  PushRemoteCommand();

  @override
  void run() async {}
}
