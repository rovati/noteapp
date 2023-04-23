import 'package:flutter/material.dart';
import 'package:notes/screen/loading.dart';
import 'package:notes/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'model/note/notifier/checklist_list.dart';
import 'model/note/notifier/main_list.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NotesList()),
      ChangeNotifierProvider(create: (_) => ChecklistManager()),
      ChangeNotifierProvider(create: (_) => AppTheme()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of all your problems
  @override
  Widget build(BuildContext context) => MaterialApp(
        themeMode: ThemeMode.dark,
        title: 'Notes',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: const LoadingPage(),
      );
}
