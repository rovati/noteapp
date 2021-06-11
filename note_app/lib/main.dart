import 'package:flutter/material.dart';
import 'package:note_app/screen/LoadingPage.dart';
import 'package:note_app/screen/MainPage.dart';

import 'util/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Themes.defaultTheme,
      home: MainPage(),
    );
  }
}
