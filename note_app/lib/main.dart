import 'package:flutter/material.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/model/checklist/ChecklistManager.dart';
import 'package:provider/provider.dart';

import 'screen/LoadingPage.dart';
import 'util/constant/app_theme.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NotesList()),
      ChangeNotifierProvider(create: (_) => ChecklistManager()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      title: 'Notes',
      theme: Themes.defaultTheme,
      home: LoadingPage(),
    );
  }
}
