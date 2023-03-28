// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auto_assistant_cli/cache_manager.dart';
import 'package:auto_assistant_cli/config.dart';
import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';
import 'package:auto_assistant_cli/http/http_client.dart';
import 'package:auto_assistant_cli/repo_manager.dart';
import 'package:auto_assistant_cli/utils/authentication_util.dart';

class PushRemoteCommand extends Command {
  @override
  final name = "push";
  @override
  final description = "push repo";

  PushRemoteCommand();

  @override
  void run() async {
    final remote =
        argResults!.arguments.isNotEmpty ? argResults?.arguments[0] : "origin";
    Config.cacheManager.refresh();
    final currentRepo = Config.cacheManager.cache!.currentRepo;
    final repoManager = RepoManager.load(currentRepo.fileName);
    if (currentRepo.remotes.isEmpty) {
      ConsoleWritter.writeError("No remote found for ${currentRepo.title}");
      return;
    }
    final currentRemote =
        currentRepo.remotes.firstWhere((element) => element.name == remote);
    ConsoleWritter.writeAttention("pushing to ${currentRemote.name}");
    ConsoleWritter.write("Prepare ${repoManager.tasks.length} tasks");
    final baererToken = Config.cacheManager.cache?.accessToken ?? "";
    final baererHeader = AuthenticationUtil.baererAuth(baererToken);
    final httpClient = HttpClient(baererAuth: baererHeader);
    httpClient.pushTask(currentRemote, repoManager.tasks);
    ConsoleWritter.writeOK("${repoManager.tasks.length} tasks created.");
  }
}
