import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/note/checklist.dart';
import '../model/note/note.dart';
import '../model/note/notifier/checklist_list.dart';
import '../model/note/notifier/main_list.dart';
import '../model/note/plaintext.dart';
import '../screen/checklist.dart';
import '../screen/plaintext.dart';
import '../theme/app_theme.dart';

class NoteTile extends StatefulWidget {
  final int noteID;

  const NoteTile(this.noteID, {super.key});

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  final NotesList list = NotesList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, child) => Container(
        decoration: BoxDecoration(
          color: appTheme.theme.semiTransparentBG,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Consumer<NotesList>(builder: (context, noteslist, child) {
          var note = noteslist.getNoteWithID(widget.noteID);
          Icon icon = note is Plaintext
              ? const Icon(Icons.dehaze_rounded)
              : const Icon(Icons.check_box_rounded);
          String title = note.title == '' ? 'New note' : note.title;
          return ListTile(
            onTap: _onTap,
            onLongPress: _onLongPress,
            leading: icon,
            trailing: note.pinned ? const Icon(Icons.push_pin_rounded) : null,
            title: Text(title),
            minVerticalPadding: 20,
            horizontalTitleGap: 10,
          );
        }),
      ),
    );
  }

  void _onTap() {
    Widget notePage;
    if (NotesList().getNoteWithID(widget.noteID) is Plaintext) {
      notePage = PlaintextPage(noteID: widget.noteID);
    } else {
      ChecklistManager().init(widget.noteID);
      notePage = const ChecklistPage();
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
