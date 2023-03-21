import 'dart:io';

import 'package:auto_assistant_cli/console/colors.dart';
import 'package:auto_assistant_cli/console/console_writter.dart';

class ExternalBrowser {
  static void runBrowser(String url) {
    var fail = false;
    switch (Platform.operatingSystem) {
      case "linux":
        Process.run("x-www-browser", [url]);
        break;
      case "macos":
        Process.run("open", [url]);
        break;
      case "windows":
        Process.run("explorer", [url]);
        break;
      default:
        fail = true;
        break;
    }

    if (!fail) {
      ConsoleWritter.writeWithColor(url, Colors.yellow);
    }
  }
}
