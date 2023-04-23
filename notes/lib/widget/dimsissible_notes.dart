import 'package:flutter/material.dart';
import 'package:notes/theme/app_theme.dart';
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
    return Consumer<AppTheme>(
      builder: (context, appTheme, child) => Consumer<NotesList>(
        builder: (context, noteslist, child) => noteslist.notes.isEmpty
            ? Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    text: TextSpan(
                      style: TextStyle(color: appTheme.theme.secondaryColor),
                      children: const [
                        TextSpan(
                          text: 'To start, open the toolbar by tapping ',
                        ),
                        WidgetSpan(
                          child:
                              Icon(Icons.keyboard_arrow_up_rounded, size: 14),
                        ),
                        TextSpan(
                          text: ' and create a plaintext note with ',
                        ),
                        WidgetSpan(
                          child: Icon(Icons.dehaze_rounded, size: 14),
                        ),
                        TextSpan(
                          text: ' or a checklist with ',
                        ),
                        WidgetSpan(
                          child: Icon(Icons.check_box_rounded, size: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: noteslist.notes.length,
                itemBuilder: (context, index) {
                  Note note = noteslist.notes[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 6, bottom: 6, left: 12, right: 12),
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
                          child: Icon(
                            Icons.delete_rounded,
                            color: appTheme.theme.secondaryColor,
                          )),
                      child: NoteTile(note.id),
                    ),
                  );
                }),
      ),
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
