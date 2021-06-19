import 'package:flutter/material.dart';
import 'package:note_app/util/DatabaseHelper.dart';

import 'Note.dart';

/// Model for the list of all notes. Used by the main page and modified by main
/// page (when creating/deleting notes) and note page (when editing a note). It
/// also takes care of reading and writing the local database.
class NotesList extends ChangeNotifier {
  static final NotesList _list = NotesList._internal();
  static final Note errorNote =
      Note(-1, 'ERROR', content: 'This note is note present in the database');
  late List<Note> notes;

  factory NotesList() {
    return _list;
  }

  NotesList._internal() {
    loadNotes().then((value) => notifyListeners());
  }

  Future<void> loadNotes() async {
    notes = await DatabaseHelper.getNotes();
  }

  void addNote(Note newNote) {
    notes.add(newNote);
    DatabaseHelper.writeNote(newNote);
    notifyListeners();
  }

  void modifyNote(Note modifiedNote) {
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].id == modifiedNote.id) {
        notes.removeAt(i);
        notes.insert(0, modifiedNote);
        DatabaseHelper.writeNote(modifiedNote);
        notifyListeners();
        return;
      }
    }
  }

  Note getNoteWithID(int id) {
    for (var note in notes) {
      if (note.id == id) {
        return note;
      }
    }
    return errorNote;
  }
}
