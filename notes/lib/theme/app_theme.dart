import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'themes.dart';

class AppTheme extends ChangeNotifier {
  static final AppTheme _appTheme = AppTheme._internal();
  late AppThemeData theme;

  factory AppTheme() {
    return _appTheme;
  }

  AppTheme._internal() {
    theme = AppThemeData.version2;
    final futPrefs = SharedPreferences.getInstance();
    futPrefs.then((prefs) {
      var themeIdx = prefs.getInt('theme') ?? 0;
      theme = AppThemeData.allThemes[themeIdx];
      prefs.setInt('theme', theme.idx);
    });
  }

  void setTheme(AppThemeData theme) {
    this.theme = theme;
    notifyListeners();
  }
}
