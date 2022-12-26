import 'package:flutter/material.dart';

class AppThemeData {
  final String name;
  final int idx;
  final Brightness brightness;
  final Widget background;
  final Color semiTransparentBG;
  final Color textColor;
  final Color toolbarShade;
  final Color toolbarBG;
  final Color toolbarIconColor;
  final Color toolbarIconTapColor;
  final Color toolbarSepColor;

  AppThemeData({
    required this.name,
    required this.idx,
    required this.brightness,
    required this.background,
    required this.semiTransparentBG,
    required this.textColor,
    required this.toolbarBG,
    required this.toolbarShade,
    required this.toolbarIconColor,
    required this.toolbarIconTapColor,
    required this.toolbarSepColor,
  });

  static final allThemes = [
    alpsSunset,
  ];

  static final alpsSunset = AppThemeData(
    name: 'Alps Sunset',
    idx: 0,
    brightness: Brightness.dark,
    background: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
          Color.fromARGB(235, 38, 114, 201),
          Color.fromARGB(255, 255, 174, 82),
        ]))),
    semiTransparentBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
    toolbarBG: const Color.fromARGB(255, 54, 54, 54),
    toolbarShade: Colors.black,
    textColor: const Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
    toolbarIconColor: Colors.white,
    toolbarIconTapColor: const Color.fromARGB(255, 77, 77, 77),
    toolbarSepColor: Colors.white54,
  ); // TODO change

  static final version2 = AppThemeData(
      name: 'Version 2',
      idx: 1,
      brightness: Brightness.dark,
      background: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
            Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
            Color.fromARGB(0xFF, 0x8E, 0xC4, 0xFF),
          ]))),
      semiTransparentBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
      toolbarBG: const Color.fromARGB(255, 54, 54, 54),
      toolbarShade: Colors.black,
      textColor: const Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
      toolbarIconColor: Colors.white,
      toolbarIconTapColor: const Color.fromARGB(255, 77, 77, 77),
      toolbarSepColor: Colors.white54);
}
