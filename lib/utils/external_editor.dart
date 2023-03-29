import 'dart:io';
import 'package:auto_assistant_cli/config.dart';

class ExternalEditor {
  static const String tmpFile = "temp.txt";

  static Future<String> showDefaultEditor() async {
    final tempFile = File(tmpFile);
    Process.runSync(
        Config.cacheManager.cache?.defaultEditorPath ?? "", [tempFile.path]);
    final content = await tempFile.readAsString();
    tempFile.delete();
    return content;
  }

  static writeTmpFile(String content) async {
    final tempFile = File(tmpFile);
    tempFile.writeAsStringSync(content);
  }
}
