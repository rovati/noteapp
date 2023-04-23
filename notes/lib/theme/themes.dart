import 'package:flutter/material.dart';

class AppThemeData {
  final String name;
  final int idx;
  final Brightness brightness;
  final Widget background;
  final Color accentColor;
  final Color secondaryColor;
  final Color noteTitleBG;
  final Color semiTransparentBG;
  final Color toolbarShade;
  final Color toolbarBG;
  final Color toolbarIconTapColor;
  final Color toolbarSepColor;

  AppThemeData({
    required this.name,
    required this.idx,
    required this.brightness,
    required this.background,
    required this.accentColor,
    required this.secondaryColor,
    required this.noteTitleBG,
    required this.semiTransparentBG,
    required this.toolbarBG,
    required this.toolbarShade,
    required this.toolbarIconTapColor,
    required this.toolbarSepColor,
  });

  static final allThemes = [
    version2,
    alpsSunset,
    solarFlare,
    flutter,
    mint,
    darkness,
    neeck,
  ];

  static final version2 = AppThemeData(
      name: 'Version 2',
      idx: 0,
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
      noteTitleBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
      semiTransparentBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
      toolbarBG: const Color.fromARGB(255, 54, 54, 54),
      toolbarShade: Colors.black,
      accentColor: const Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
      secondaryColor: Colors.white,
      toolbarIconTapColor: const Color.fromARGB(255, 77, 77, 77),
      toolbarSepColor: Colors.white54);

  static final alpsSunset = AppThemeData(
    name: 'Alps Sunset',
    idx: 1,
    brightness: Brightness.dark,
    background: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
          Color.fromARGB(0xff, 0x46, 0x75, 0x99),
          Color.fromARGB(0xff, 0xBD, 0xD5, 0xEA),
          Color.fromARGB(0xff, 0xf1, 0x9c, 0x79),
        ]))),
    noteTitleBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
    semiTransparentBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
    toolbarBG: const Color.fromARGB(255, 54, 54, 54),
    toolbarShade: Colors.black,
    accentColor: const Color.fromARGB(0xff, 0x46, 0x75, 0x99),
    secondaryColor: Colors.white,
    toolbarIconTapColor: const Color.fromARGB(255, 77, 77, 77),
    toolbarSepColor: Colors.white54,
  );

  static final solarFlare = AppThemeData(
    name: 'Solar flare',
    idx: 2,
    brightness: Brightness.dark,
    background: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
          Color.fromARGB(255, 255, 205, 113),
          Color.fromARGB(255, 255, 91, 99),
        ]))),
    noteTitleBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
    semiTransparentBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
    toolbarBG: const Color.fromARGB(255, 54, 54, 54),
    toolbarShade: Colors.black,
    accentColor: const Color.fromARGB(255, 255, 91, 99),
    secondaryColor: Colors.white,
    toolbarIconTapColor: const Color.fromARGB(255, 77, 77, 77),
    toolbarSepColor: Colors.white54,
  );

  static final flutter = AppThemeData(
    name: 'Flutter',
    idx: 3,
    brightness: Brightness.dark,
    background: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
          Color.fromARGB(255, 113, 186, 255),
          Color.fromARGB(255, 56, 107, 248),
        ]))),
    noteTitleBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
    semiTransparentBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
    toolbarBG: const Color.fromARGB(255, 54, 54, 54),
    toolbarShade: Colors.black,
    accentColor: const Color.fromARGB(255, 56, 107, 248),
    secondaryColor: Colors.white,
    toolbarIconTapColor: const Color.fromARGB(255, 77, 77, 77),
    toolbarSepColor: Colors.white54,
  );

  static final mint = AppThemeData(
    name: 'Mint',
    idx: 4,
    brightness: Brightness.dark,
    background: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
          Color.fromARGB(255, 113, 255, 172),
          Color.fromARGB(255, 91, 107, 255),
        ]))),
    noteTitleBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
    semiTransparentBG: const Color.fromARGB(0x13, 0x29, 0x29, 0x29),
    toolbarBG: const Color.fromARGB(255, 54, 54, 54),
    toolbarShade: Colors.black,
    accentColor: const Color.fromARGB(255, 113, 255, 172),
    secondaryColor: Colors.white,
    toolbarIconTapColor: const Color.fromARGB(255, 77, 77, 77),
    toolbarSepColor: Colors.white54,
  );

  static final darkness = AppThemeData(
    name: 'Darkness',
    idx: 5,
    brightness: Brightness.dark,
    background: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
          Color.fromARGB(255, 68, 68, 68),
          Color.fromARGB(255, 39, 39, 39),
        ]))),
    noteTitleBG: const Color.fromARGB(19, 160, 160, 160),
    semiTransparentBG: const Color.fromARGB(19, 160, 160, 160),
    toolbarBG: const Color.fromARGB(255, 54, 54, 54),
    toolbarShade: Colors.black,
    accentColor: const Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
    secondaryColor: Colors.white,
    toolbarIconTapColor: const Color.fromARGB(255, 77, 77, 77),
    toolbarSepColor: Colors.white54,
  );

  static final neeck = AppThemeData(
      name: 'Neeck',
      idx: 6,
      brightness: Brightness.dark,
      background: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 37, 37, 37)),
      ),
      noteTitleBG: const Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
      semiTransparentBG: const Color.fromARGB(19, 94, 94, 94),
      toolbarBG: const Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
      toolbarShade: Colors.black,
      accentColor: const Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
      secondaryColor: Colors.white,
      toolbarIconTapColor: const Color.fromARGB(255, 77, 77, 77),
      toolbarSepColor: Colors.white54);
}
