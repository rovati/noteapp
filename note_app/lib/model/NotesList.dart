import 'package:flutter/material.dart';
import 'package:note_app/util/DatabaseHelper.dart';

import 'Note.dart';
import 'Plaintext.dart';
import 'Ordering.dart';

/// Model for the list of all notes. Used by the main page and modified by main
/// page (when creating/deleting notes) and note page (when editing a note). It
/// also takes care of reading and writing the local database.
class NotesList extends ChangeNotifier {
  static final NotesList _list = NotesList._internal();
  static final Plaintext errorNote = Plaintext(-1,
      title: 'ERROR', content: 'This note is note present in the database');
  late List<Note> notes;
  late Ordering ordering;
  late int nbPinned;

  factory NotesList() {
    return _list;
  }

  NotesList._internal() {
    loadNotes().then((value) => notifyListeners());
  }

  Future<void> loadNotes() async {
    ordering = Ordering();
    notes = await DatabaseHelper.getNotes();
    nbPinned = 0;
    for (int i = 0; i < notes.length; i++) {
      ordering.append(notes[i].id);
      if (notes[i].pinned) {
        nbPinned++;
      }
    }
  }

  void addNote(Note newNote) {
    notes.insert(nbPinned, newNote);
    ordering.insertAt(newNote.id, nbPinned);
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
        if (!modifiedNote.pinned) {
          ordering.moveTo(modifiedNote.id, nbPinned);
        }
        DatabaseHelper.writeNote(modifiedNote, ordering);
        notifyListeners();
        return;
      }
    }
  }

  void pinNote(Note pinnedNote) {
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].id == pinnedNote.id) {
        notes.removeAt(i);
        notes.insert(nbPinned, pinnedNote);
        ordering.moveTo(pinnedNote.id, nbPinned);
        nbPinned++;
        DatabaseHelper.writeNote(pinnedNote, ordering);
        notifyListeners();
        return;
      }
    }
  }

  void unpinNote(Note unpinnedNote) {
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].id == unpinnedNote.id) {
        notes.removeAt(i);
        notes.insert(nbPinned, unpinnedNote);
        ordering.moveTo(unpinnedNote.id, nbPinned);
        nbPinned--;
        DatabaseHelper.writeNote(unpinnedNote, ordering);
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
