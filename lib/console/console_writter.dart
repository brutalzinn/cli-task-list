import 'package:auto_assistant_cli/console/colors.dart';

class ConsoleWritter {
  static void write(String text) {
    writeWithColor(text, Colors.white);
  }

  static void writeWarning(String text) {
    writeWithColor("WARNING!", Colors.yellow);
    writeWithColor(text, Colors.white);
  }

  static void writeAttention(String text) {
    writeWithColor("Attention!", Colors.yellow);
    writeWithColor(text, Colors.white);
  }

  static void writeError(String text) {
    writeWithColor("ERROR!", Colors.red);
    writeWithColor(text, Colors.red);
  }

  static void writeOK(String text) {
    writeWithColor(text, Colors.green);
  }

  static void writeWithColor(String text, String color) {
    print('$color$text${Colors.noColor}');
  }
}
