import 'package:flutter/material.dart';

import '../model/note/notifier/checklist_list.dart';
import 'checklist_tile.dart';

class DismissibleChecklist extends StatefulWidget {
  const DismissibleChecklist({super.key});

  @override
  State<DismissibleChecklist> createState() => _DismissibleCLState();
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
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.remove_circle_rounded, size: 18),
                  onPressed: () => _onTapRemoveElement(index),
                ),
              )
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 1),
            child: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.add_rounded),
                onPressed: _onTapAddElement,
              ),
              title: const Text(
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
