import 'package:flutter/material.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/util/DatabaseHelper.dart';

import 'MainPage.dart';

class LoadingPage extends StatelessWidget {
  void navigateWhenComplete(BuildContext context) {
    final notes = NotesList();
    DatabaseHelper.getNotes().then((list) => {
          for (var note in list) {notes.addNote(note)},
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    navigateWhenComplete(context);
    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 3.0,
          child: CircularProgressIndicator(
            color: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
            strokeWidth: 2.0,
          ),
        ),
      ),
    );
  }
}
