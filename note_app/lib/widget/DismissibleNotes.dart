import 'package:flutter/material.dart';
import 'package:note_app/model/Note.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:provider/provider.dart';

import 'NoteTile.dart';

class DismissibleNotes extends StatefulWidget {
  @override
  _DismissibleNotesState createState() => _DismissibleNotesState();
}

class _DismissibleNotesState extends State<DismissibleNotes> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotesList>(
      builder: (context, noteslist, child) => ListView.builder(
          itemCount: noteslist.notes.length,
          itemBuilder: (context, index) {
            Note note = noteslist.notes[index];
            return Padding(
              padding: EdgeInsets.only(top: 12),
              child: Dismissible(
                key: UniqueKey(),
                child: NoteTile(note.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) =>
                    _onDismissDelete(direction, note.id),
                background: Container(
                  color: Colors.transparent,
                ),
                secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                    )),
              ),
            );
          }),
    );
  }

  void _onDismissDelete(DismissDirection dir, int noteID) {
    var note = NotesList().getNoteWithID(noteID);
    NotesList().removeNote(noteID);
    SnackBar snack = SnackBar(
      content: Text('Note deleted'),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () => NotesList().addNote(note),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
