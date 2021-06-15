import 'package:flutter/material.dart';

import 'Note.dart';

/// Model for the list of all notes. Used by the main page and modified by main
/// page (when creating/deleting notes) and note page (when editing a note). It
/// also takes care of reading and writing the local database.
class NotesList extends ChangeNotifier {
  static final NotesList _list = NotesList._internal();
  late List<Note> notes;

  factory NotesList() {
    return _list;
  }

  NotesList._internal() {
    this.notes = [];
  }

  void addNote(Note newNote) {
    notes.add(newNote);
    notifyListeners();
  }

  String getTitleOf(int id) {
    return 'New note ' + id.toString();
  }

  String getContentOf(int id) {
    return 'No content';
  }
}
