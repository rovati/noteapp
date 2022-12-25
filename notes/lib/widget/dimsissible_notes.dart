import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/note/note.dart';
import '../model/note/notifier/main_list.dart';
import 'note_tile.dart';

class DismissibleNotes extends StatefulWidget {
  const DismissibleNotes({super.key});

  @override
  State<DismissibleNotes> createState() => _DismissibleNotesState();
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
              padding: const EdgeInsets.only(top: 6, bottom: 6),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) =>
                    _onDismissDelete(direction, note.id),
                background: Container(
                  color: Colors.transparent,
                ),
                secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                    )),
                child: NoteTile(note.id),
              ),
            );
          }),
    );
  }

  void _onDismissDelete(DismissDirection dir, int noteID) {
    var note = NotesList().getNoteWithID(noteID);
    NotesList().removeNote(noteID);
    SnackBar snack = SnackBar(
      content: const Text('Note deleted'),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () => NotesList().addNote(note),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
