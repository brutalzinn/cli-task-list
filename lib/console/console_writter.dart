import 'package:auto_assistant_cli/console/colors.dart';

class ConsoleWritter {
  static void write(String text) {
    writeWithColor(text, Colors.white);
  }

  static void writeImportant(String text) {
    writeWithColor("WARNING!", Colors.yellow);
    writeWithColor(text, Colors.red);
  }

  static void writeError(String text) {
    writeWithColor("ERROR!", Colors.red);
    writeWithColor(text, Colors.red);
  }

  static void writeWithColor(String text, String color) {
    print('$color$text${Colors.noColor}');
  }
}
