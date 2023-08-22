import 'package:flutter/material.dart';

import '../model/note/notifier/checklist_list.dart';
import 'checklist_tile.dart';

class ChecklistGroupTile extends StatefulWidget {
  final int groupIdx;

  const ChecklistGroupTile(this.groupIdx, {super.key});

  @override
  State<StatefulWidget> createState() => _CLGroupTileState();
}

class _CLGroupTileState extends State<ChecklistGroupTile> {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Center(
              child: Text(ChecklistManager().groupAt(widget.groupIdx).title)),
          ListView.builder(
            itemCount:
                ChecklistManager().groupAt(widget.groupIdx).uncheckedLength,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  ChecklistTile(widget.groupIdx, index, false),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.remove_circle_rounded, size: 18),
                      onPressed: () => _onTapRemoveUncheckedElement(index),
                    ),
                  )
                ],
              );
            },
          ),
          // TODO add separator line
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          ListView.builder(
            itemCount:
                ChecklistManager().groupAt(widget.groupIdx).checkedLength,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  ChecklistTile(widget.groupIdx, index, true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.remove_circle_rounded, size: 18),
                      onPressed: () => _onTapRemoveCheckedElement(index),
                    ),
                  )
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.add_rounded),
                onPressed: _onTapAddElement,
              ),
              title: const Text('Add element'),
              onTap: _onTapAddElement,
            ),
          )
        ],
      );

  void _onTapRemoveUncheckedElement(idx) {
    ChecklistManager().removeUncheckedElementFromGroup(widget.groupIdx, idx);
    setState(() {});
  }

  void _onTapRemoveCheckedElement(idx) {
    ChecklistManager().removeCheckedElementFromGroup(widget.groupIdx, idx);
    setState(() {});
  }

  void _onTapAddElement() {
    ChecklistManager().addElementToGroup(widget.groupIdx);
  }
}
