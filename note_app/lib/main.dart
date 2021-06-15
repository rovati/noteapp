import 'package:flutter/material.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:provider/provider.dart';

import 'model/Note.dart';
import 'screen/LoadingPage.dart';
import 'screen/NotePage.dart';
import 'util/constant/app_theme.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (context) => NotesList(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final note = Note(0, 'test title', content: 'content test');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Themes.defaultTheme,
      home: NotePage(
        note: note,
      ),
    );
  }
}
