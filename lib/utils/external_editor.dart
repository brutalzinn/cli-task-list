import 'dart:io';

import 'package:auto_assistant_cli/config.dart';

class ExternalEditor {
  static const String tmpFile = "temp.txt";

  static Future<String> showDefaultEditor() async {
    final tempFile = File(tmpFile);
    if (Platform.isWindows) {
      Process.runSync(Config.defaultEditor, [tempFile.path]);
    } else if (Platform.isLinux) {
      await Process.start('notepad-plus-plus', [tempFile.path]);
    }
    final content = await tempFile.readAsString();
    tempFile.delete();
    return content;
  }

  static writeTmpFile(String content) async {
    final tempFile = File(tmpFile);
    tempFile.writeAsStringSync(content);
  }
}
