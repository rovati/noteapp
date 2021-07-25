import 'package:flutter/material.dart';
import 'package:note_app/model/checklist/ChecklistElement.dart';

class ChecklistTile extends StatefulWidget {
  final void saveCallback;
  final ChecklistElement content;

  ChecklistTile(this.content, this.saveCallback);

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
}
