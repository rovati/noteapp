import 'package:flutter/material.dart';
import 'package:note_app/model/checklist/Checklist.dart';
import 'package:note_app/model/checklist/ChecklistElement.dart';
import 'package:note_app/widget/ChecklistTile.dart';

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
    for (int i = 0; i < _note.length(); i++) {
      controllers.add(TextEditingController(text: _note.elementAt(i).content));
    }
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
      itemCount: _note.length() + 1,
      itemBuilder: (context, index) {
        if (index < _note.length()) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ChecklistTile(_note.elementAt(index)),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.remove_circle_rounded, size: 18),
                  onPressed: () => _onTapRemoveElement(index),
                ),
              )
            ],
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: ListTile(
              leading: Icon(Icons.add_rounded),
              title: Text('Add item'),
              onTap: _onTapAddElement,
            ),
          );
        }
      },
    );
  }

  void _onTapAddElement() {
    setState(() {
      _note.addElement();
    });
  }

  void _onTapRemoveElement(idx) {
    setState(() {
      _note.deleteElementAt(idx);
    });
  }
}
