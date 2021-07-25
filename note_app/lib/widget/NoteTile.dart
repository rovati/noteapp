import 'package:flutter/material.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/model/Plaintext.dart';
import 'package:note_app/screen/PlaintextPage.dart';
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
        gradient: LinearGradient(colors: [
          Color.fromARGB(0x22, 0xC1, 0xC1, 0xC1),
          Color.fromARGB(0x22, 0xC1, 0xC1, 0xC1)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
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
          leading: icon,
          title: Text(title),
          minVerticalPadding: 20,
          horizontalTitleGap: 10,
        );
      }),
    );
  }

  void _onTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlaintextPage(noteID: widget.noteID)));
  }
}
