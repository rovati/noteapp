import 'package:flutter/material.dart';
import 'package:note_app/util/DatabaseHelper.dart';

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
    loadNotes().then((value) => notifyListeners());
  }

  Future<void> loadNotes() async {
    notes = await DatabaseHelper.getNotes();
    print('LD - notes length: ' + notes.length.toString());
  }

  void addNote(Note newNote) {
    notes.add(newNote);
    print('ADD - notes length: ' + notes.length.toString());
    DatabaseHelper.writeNote(newNote);
    notifyListeners();
  }

  void modifyNote(Note modifiedNote) {
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].id == modifiedNote.id) {
        notes.remove(i);
        notes = [modifiedNote, ...notes];
        DatabaseHelper.writeNote(modifiedNote);
        notifyListeners();
        return;
      }
    }
  }

  String getTitleOf(int id) {
    return 'New note ' + id.toString();
  }

  String getContentOf(int id) {
    return 'No content';
  }
}
