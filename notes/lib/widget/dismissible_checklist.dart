import 'package:flutter/material.dart';
import 'package:notes/model/note/checklist_group.dart';
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
  Widget build(BuildContext context) {
    return Consumer<ChecklistManager>(
      builder: (context, checklist, child) => SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
              padding: const EdgeInsets.symmetric(vertical: 15),
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
      ),
    );
  }

  void _onTapAddElement() {
    ChecklistManager().addGroup();
    setState(() {});
  }

  void _onTapRemoveGroup(idx) {
    ChecklistGroup gr = ChecklistManager().groupAt(idx);
    ChecklistManager().removeGroup(idx);
    setState(() {});
    SnackBar snack = SnackBar(
      showCloseIcon: true,
      content: const Text('Group deleted'),
      action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            ChecklistManager().addGroupAt(gr, idx);
            setState(() {});
          }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
