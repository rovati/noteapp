import 'package:flutter/material.dart';
import 'package:notes/theme/app_theme.dart';
import 'package:provider/provider.dart';

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
    return Consumer<ChecklistManager>(
      builder: (context, checklist, child) => Column(
        children: [
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
            shrinkWrap: true,
            itemCount: checklist.groupsCount(),
            itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => _onTapRemoveGroup(index),
              background: Container(
                color: Colors.transparent,
              ),
              secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete_rounded,
                    color: AppTheme().theme.secondaryColor,
                  )),
              child: ChecklistGroupTile(index),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: GestureDetector(
                onTap: _onTapAddElement,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_rounded),
                    Text(
                      'Add group',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
