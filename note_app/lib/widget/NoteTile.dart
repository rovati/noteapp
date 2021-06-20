import 'package:flutter/material.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/screen/NotePage.dart';
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
        child: ListTile(
          onTap: _onTap,
          leading: Icon(Icons.dehaze_outlined),
          title: Consumer<NotesList>(
              builder: (context, noteslist, child) =>
                  Text(noteslist.getNoteWithID(widget.noteID).title)),
          minVerticalPadding: 20,
          horizontalTitleGap: 10,
        ));
  }

  void _onTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotePage(noteID: widget.noteID)));
  }
}
