import 'package:flutter/material.dart';
import 'package:notes/screen/loading.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of all your problems
  @override
  Widget build(BuildContext context) => MaterialApp(
        themeMode: ThemeMode.dark,
        title: 'Notes',
        theme: Themes.defaultTheme,
        home: const LoadingPage(),
      );
}
