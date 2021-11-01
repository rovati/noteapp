import 'package:flutter/material.dart';

class Themes {
  static final defaultTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
    // accentColor: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
  );

  static final red = Color.fromARGB(0xFF, 0xE1, 0x55, 0x54);
  static final lightBlue = Color.fromARGB(0xFF, 0x8E, 0xC4, 0xFF);
  static final grey = Color.fromARGB(0xFF, 0x20, 0x20, 0x20);
  static final tileBg = Color.fromARGB(0x33, 0x29, 0x29, 0x29);
  static final plaintextBg = Color.fromARGB(0x13, 0x29, 0x29, 0x29);
  static final titleBg = Color.fromARGB(0x10, 0xFF, 0xFF, 0xFF);
  static final titleOutline = Color.fromARGB(0x70, 0xFF, 0xFF, 0xFF);

  static final Widget background = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          red,
          lightBlue,
        ])
    ),
  );
}
