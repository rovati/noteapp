import 'package:flutter/material.dart';
import 'package:notes/model/storage/local_db.dart';
import 'package:notes/model/storage/notes_order.dart';

import '../note.dart';
import '../plaintext.dart';

/// Model for the list of all notes. Used by the main page and modified by main
/// page (when creating/deleting notes) and note page (when editing a note). It
/// also takes care of reading and writing the local database.
class NotesList extends ChangeNotifier {
  static final NotesList _list = NotesList._internal();
  static final Plaintext errorNote = Plaintext(-1,
      title: 'ERROR', content: 'This note is note present in the database');
  late List<Note> notes;
  late NotesOrder ordering;
  late int nbPinned;

  factory NotesList() {
    return _list;
  }

  NotesList._internal() {
    notes = [];
    loadNotes().then((value) => notifyListeners());
  }

  Future<void> loadNotes() async {
    ordering = NotesOrder();
    notes = (await LocalDB.getNotes()).parsed;
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
    LocalDB.writeNote(newNote, ordering);
    notifyListeners();
  }

  void removeNote(int noteID) {
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].id == noteID) {
        notes.removeAt(i);
        ordering.remove(noteID);
        LocalDB.deleteNote(noteID, ordering);
        notifyListeners();
        return;
      }
    }
  }

  void modifyNote(Note modifiedNote) {
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].id == modifiedNote.id) {
        notes.removeAt(i);
        if (!modifiedNote.pinned) {
          notes.insert(nbPinned, modifiedNote);
          ordering.moveTo(modifiedNote.id, nbPinned);
        } else {
          notes.insert(i, modifiedNote);
        }
        LocalDB.writeNote(modifiedNote, ordering);
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
        LocalDB.writeNote(pinnedNote, ordering);
        notifyListeners();
        return;
      }
    }
  }

  void unpinNote(Note unpinnedNote) {
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].id == unpinnedNote.id) {
        notes.removeAt(i);
        nbPinned--;
        notes.insert(nbPinned, unpinnedNote);
        ordering.moveTo(unpinnedNote.id, nbPinned);
        LocalDB.writeNote(unpinnedNote, ordering);
        notifyListeners();
        return;
      }
    }
  }

  void togglePin(Note toggledNote) {
    if (toggledNote.pinned) {
      pinNote(toggledNote);
    } else {
      unpinNote(toggledNote);
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
