import 'package:flutter/material.dart';

import 'themes.dart';

class AppTheme extends ChangeNotifier {
  static final AppTheme _appTheme = AppTheme._internal();
  late AppThemeData theme;

  factory AppTheme() {
    return _appTheme;
  }

  AppTheme._internal() {
    // TODO load from shared preferences
    theme = AppThemeData.version2;
  }
}
