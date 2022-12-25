import 'package:flutter/material.dart';

class Themes {
  static final defaultTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
    // accentColor: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
  );

  static const red = Color.fromARGB(0xFF, 0xE1, 0x55, 0x54);
  static const lightBlue = Color.fromARGB(0xFF, 0x8E, 0xC4, 0xFF);
  static const grey = Color.fromARGB(0xFF, 0x20, 0x20, 0x20);
  static const lightGrey = Color.fromARGB(255, 54, 54, 54);
  static const tileBg = Color.fromARGB(0x33, 0x29, 0x29, 0x29);
  static const plaintextBg = Color.fromARGB(0x13, 0x29, 0x29, 0x29);
  static const titleBg = Color.fromARGB(0x10, 0xFF, 0xFF, 0xFF);
  static const titleOutline = Color.fromARGB(0x70, 0xFF, 0xFF, 0xFF);

  static final Widget background = Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          red,
          lightBlue,
        ])),
  );
}
