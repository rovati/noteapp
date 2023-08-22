import 'package:flutter/material.dart';

import '../model/note/notifier/checklist_list.dart';
import 'checklist_group_tile.dart';

class DismissibleChecklist extends StatefulWidget {
  const DismissibleChecklist({super.key});

  @override
  State<DismissibleChecklist> createState() => _DismissibleCLState();
}

class _DismissibleCLState extends State<DismissibleChecklist> {
  @override
  // TODO separate list and new group button
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ChecklistManager().groupsCount() + 1,
      itemBuilder: (context, index) {
        if (index < ChecklistManager().groupsCount()) {
          return Stack(
            children: [
              ChecklistGroupTile(index),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.remove_circle_rounded, size: 18),
                  onPressed: () => _onTapRemoveGroup(index),
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
              title: const Text('Add group'),
              onTap: _onTapAddElement,
            ),
          );
        }
      },
    );
  }

  void _onTapAddElement() {
    ChecklistManager().addGroup();
    setState(() {});
  }

  void _onTapRemoveGroup(idx) {
    ChecklistManager().removeGroup(idx);
    setState(() {});
  }
}
