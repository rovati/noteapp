import 'package:flutter/material.dart';
import 'package:note_app/model/Note.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/screen/NotePage.dart';

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
        child: ListTile(
          onTap: _onTap,
          leading: Icon(Icons.dehaze_outlined),
          title: Text(list.getTitleOf(widget.noteID)),
          minVerticalPadding: 20,
          horizontalTitleGap: 10,
        ));
  }

  void _onTap() {
    Note note = Note(0, 'Note title', content: 'test content');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotePage(note: note)));
  }
}
