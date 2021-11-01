import 'package:flutter/material.dart';
import 'package:note_app/model/checklist/ChecklistManager.dart';
import 'package:note_app/widget/ChecklistTile.dart';

class DismissibleChecklist extends StatefulWidget {
  DismissibleChecklist();

  @override
  _DismissibleCLState createState() => _DismissibleCLState();
}

class _DismissibleCLState extends State<DismissibleChecklist> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ChecklistManager().elems.length + 1,
      itemBuilder: (context, index) {
        if (index < ChecklistManager().elems.length) {
          return Stack(
            children: [
              ChecklistTile(index),
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
            padding: EdgeInsets.only(top: 1),
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.add_rounded),
                onPressed: _onTapAddElement,
              ),
              title: Text(
                'Add item',
              ),
              onTap: _onTapAddElement,
            ),
          );
        }
      },
    );
  }

  void _onTapAddElement() {
    ChecklistManager().addElement();
    setState(() {});
  }

  void _onTapRemoveElement(idx) {
    ChecklistManager().removeElement(idx);
    setState(() {});
  }
}
