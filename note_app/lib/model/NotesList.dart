import 'package:flutter/material.dart';
import 'package:note_app/util/DatabaseHelper.dart';

import 'Note.dart';
import 'Ordering.dart';

/// Model for the list of all notes. Used by the main page and modified by main
/// page (when creating/deleting notes) and note page (when editing a note). It
/// also takes care of reading and writing the local database.
class NotesList extends ChangeNotifier {
  static final NotesList _list = NotesList._internal();
  static final Note errorNote =
      Note(-1, 'ERROR', content: 'This note is note present in the database');
  late List<Note> notes;
  late Ordering ordering;

  factory NotesList() {
    return _list;
  }

  NotesList._internal() {
    loadNotes().then((value) => notifyListeners());
  }

  Future<void> loadNotes() async {
    ordering = Ordering();
    notes = await DatabaseHelper.getNotes();
    for (int i = 0; i < notes.length; i++) {
      ordering.append(notes[i].id);
    }
  }

  void addNote(Note newNote) {
    notes.insert(0, newNote);
    ordering.prepend(newNote.id);
    DatabaseHelper.writeNote(newNote, ordering);
    notifyListeners();
  }

  void removeNote(int noteID) {
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].id == noteID) {
        notes.removeAt(i);
        ordering.remove(noteID);
        DatabaseHelper.deleteNote(noteID, ordering);
        notifyListeners();
        return;
      }
    }
  }

  void modifyNote(Note modifiedNote) {
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].id == modifiedNote.id) {
        notes.removeAt(i);
        notes.insert(0, modifiedNote);
        ordering.bump(modifiedNote.id);
        DatabaseHelper.writeNote(modifiedNote, ordering);
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
