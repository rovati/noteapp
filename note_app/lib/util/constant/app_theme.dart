import 'package:flutter/material.dart';

class Themes {
  static final defaultTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
    // accentColor: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
  );

  static final red = Color.fromARGB(0xFF, 0xE1, 0x55, 0x54);
  static final grey = Color.fromARGB(0xFF, 0x20, 0x20, 0x20);

  static final Widget background = Container(
    decoration: BoxDecoration(color: grey),
  );
}
