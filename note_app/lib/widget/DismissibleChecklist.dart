import 'package:flutter/material.dart';
import 'package:note_app/model/checklist/Checklist.dart';
import 'package:note_app/model/checklist/ChecklistElement.dart';

import 'ChecklistTile.dart';

class DismissibleChecklist extends StatefulWidget {
  final Checklist note;

  DismissibleChecklist(this.note);

  @override
  _DismissibleCLState createState() => _DismissibleCLState();
}

class _DismissibleCLState extends State<DismissibleChecklist> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.note.length(),
      itemBuilder: (context, index) {
        ChecklistElement el = widget.note.elementAt(index);
        return Padding(
          padding: EdgeInsets.only(top: 12),
          child: Dismissible(
            key: UniqueKey(),
            child: ChecklistTile(el, () {}),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => {},
            background: Container(
              color: Colors.transparent,
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete_rounded,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}
