import 'package:flutter/material.dart';
import 'package:note_app/model/Note.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/model/Plaintext.dart';
import 'package:note_app/model/checklist/Checklist.dart';
import 'package:note_app/model/checklist/ChecklistManager.dart';
import 'package:note_app/screen/ChecklistPage.dart';
import 'package:note_app/screen/PlaintextPage.dart';
import 'package:note_app/util/constant/app_theme.dart';
import 'package:provider/provider.dart';

class NoteTile extends StatefulWidget {
  final int noteID;

  NoteTile(this.noteID);

  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  final NotesList list = NotesList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Themes.tileBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Consumer<NotesList>(builder: (context, noteslist, child) {
        var note = noteslist.getNoteWithID(widget.noteID);
        Icon icon = note is Plaintext
            ? Icon(Icons.dehaze_rounded)
            : Icon(Icons.check_box_rounded);
        String title = note.title == '' ? 'New note' : note.title;
        return ListTile(
          onTap: _onTap,
          onLongPress: _onLongPress,
          leading: icon,
          trailing: note.pinned ? Icon(Icons.push_pin_rounded) : null,
          title: Text(title),
          minVerticalPadding: 20,
          horizontalTitleGap: 10,
        );
      }),
    );
  }

  void _onTap() {
    Widget notePage;
    if (NotesList().getNoteWithID(widget.noteID) is Plaintext) {
      notePage = PlaintextPage(noteID: widget.noteID);
    } else {
      ChecklistManager().init(widget.noteID);
      notePage = ChecklistPage();
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => notePage));
  }

  void _onLongPress() {
    Note note = NotesList().getNoteWithID(widget.noteID);
    if (note is Plaintext) {
      Plaintext toggled = Plaintext(widget.noteID,
          title: note.title, content: note.content, pinned: !note.pinned);
      NotesList().togglePin(toggled);
    } else if (note is Checklist) {
      Checklist toggled = Checklist(widget.noteID,
          title: note.title, chContent: note.chContent, pinned: !note.pinned);
      NotesList().togglePin(toggled);
    }
  }
}
