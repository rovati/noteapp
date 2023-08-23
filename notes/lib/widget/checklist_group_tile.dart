import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/note/notifier/checklist_list.dart';
import '../theme/app_theme.dart';
import 'checklist_tile.dart';

class ChecklistGroupTile extends StatefulWidget {
  final int groupIdx;

  const ChecklistGroupTile(this.groupIdx, {super.key});

  @override
  State<StatefulWidget> createState() => _CLGroupTileState();
}

class _CLGroupTileState extends State<ChecklistGroupTile> {
  @override
  Widget build(BuildContext context) => Consumer<AppTheme>(
        builder: (context, appTheme, child) => Container(
          decoration: BoxDecoration(
            color: appTheme.theme.noteTitleBG,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Center(
                    child: Text(
                        ChecklistManager().groupAt(widget.groupIdx).title)),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: ChecklistManager()
                      .groupAt(widget.groupIdx)
                      .uncheckedLength,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ChecklistTile(widget.groupIdx, index, false),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.remove_circle_rounded,
                                size: 18),
                            onPressed: () =>
                                _onTapRemoveUncheckedElement(index),
                          ),
                        )
                      ],
                    );
                  },
                ),
                // TODO add separator line
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      ChecklistManager().groupAt(widget.groupIdx).checkedLength,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ChecklistTile(widget.groupIdx, index, true),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.remove_circle_rounded,
                                size: 18),
                            onPressed: () => _onTapRemoveCheckedElement(index),
                          ),
                        )
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Center(
                    child: GestureDetector(
                      onTap: _onTapAddElement,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_rounded),
                          Text(
                            'Add element',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
    // NOTE change to consumer? it would still rebuild all groups...
    setState(() {});
  }
}
