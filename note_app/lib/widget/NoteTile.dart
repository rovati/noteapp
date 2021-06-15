import 'package:flutter/material.dart';
import 'package:note_app/model/NotesList.dart';

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
          //color: Colors.transparent,
          gradient: LinearGradient(colors: [
            Color.fromARGB(0x22, 0xC1, 0xC1, 0xC1),
            Color.fromARGB(0x22, 0xC1, 0xC1, 0xC1)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),

          /* border: Border.all(
            color: Color.fromARGB(0xAA, 0xE1, 0x55, 0x54),
            width: 2,
          ), */
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          onTap: () {},
          leading: Icon(Icons.dehaze_outlined),
          title: Text(list.getTitleOf(widget.noteID)),
          minVerticalPadding: 20,
          horizontalTitleGap: 10,
        ));
  }
}
