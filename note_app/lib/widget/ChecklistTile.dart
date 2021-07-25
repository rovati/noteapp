import 'package:flutter/material.dart';
import 'package:note_app/screen/ChecklistPage.dart';

class ChecklistTile extends StatefulWidget {
  final int noteID;

  ChecklistTile(this.noteID);

  @override
  _ChecklistTileState createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<ChecklistTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Icon(Icons.check_box_outline_blank_rounded),
      title: Text('Checklist element'),
    );
  }

// Icons.check_box_outline_blank_rounded
}
