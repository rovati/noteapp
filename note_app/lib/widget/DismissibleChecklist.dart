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
  List<TextEditingController> controllers = [];
  late Checklist _note = widget.note;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (TextEditingController contr in controllers) {
      contr.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _note.length(),
      itemBuilder: (context, index) {
        ChecklistElement el = _note.elementAt(index);
        return Padding(
          padding: EdgeInsets.only(top: 12),
          child: Dismissible(
            key: UniqueKey(),
            child: ListTile(), // TODO
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _onDismissRemove(direction, index),
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

  void _onDismissRemove(DismissDirection dir, int index) {
    _note.deleteElementAt(index);
    controllers[index].dispose();
    controllers.removeAt(index);
    // TODO save!!
  }

  Widget tile(int idx) {
    TextEditingController _controller =
        TextEditingController(text: widget.note.elementAt(idx).content);
    controllers.add(_controller);
    return ListTile(
      leading: Icon(Icons.check_box_outline_blank_rounded),
      title: TextField(
        controller: _controller,
        onSubmitted: (string) => _onSubmitted(idx),
        textInputAction: TextInputAction.next,
      ),
    );
  }

  void _onSubmitted(int idx) {
    setState(() {
      _note.addElementAfter(idx);
    });
  }
}
