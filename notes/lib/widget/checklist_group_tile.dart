import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/note/notifier/checklist_list.dart';
import '../theme/app_theme.dart';
import 'checklist_tile.dart';

class ChecklistGroupTile extends StatefulWidget {
  final int groupIdx;
  final Function(int) deletionCallback;

  const ChecklistGroupTile(this.groupIdx,
      {super.key, required this.deletionCallback});

  @override
  State<StatefulWidget> createState() => _CLGroupTileState();
}

class _CLGroupTileState extends State<ChecklistGroupTile> {
  final TextEditingController _titleController = TextEditingController();
  double _turns = 0;
  bool _displayCheckedItems = false;

  @override
  void initState() {
    super.initState();
    _titleController.text =
        ChecklistManager().note.groups[widget.groupIdx].title;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, child) => Container(
        decoration: BoxDecoration(
          color: appTheme.theme.semiTransparentBG,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Consumer<ChecklistManager>(
          builder: (context, manager, child) => Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: TextField(
                        onChanged: _onGroupTitleModified,
                        maxLines: 1,
                        maxLength: 30,
                        textInputAction: TextInputAction.done,
                        controller: _titleController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          hintText: 'Group title',
                          border: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () =>
                            widget.deletionCallback(widget.groupIdx),
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: manager.groupAt(widget.groupIdx).uncheckedLength,
                  itemBuilder: (context, index) {
                    return ChecklistTile(widget.groupIdx, index, false);
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
                Visibility(
                  visible:
                      manager.note.groups[widget.groupIdx].checkedLength > 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 2,
                            color: appTheme.theme.secondaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: _onTapToggleShowCheckedItems,
                          icon: AnimatedRotation(
                            turns: _turns,
                            duration: const Duration(milliseconds: 250),
                            child:
                                const Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !_displayCheckedItems,
                  child: Center(
                    child: Opacity(
                      opacity: 0.75,
                      child: Text(
                        '${manager.note.groups[widget.groupIdx].checkedLength} checked item${manager.note.groups[widget.groupIdx].checkedLength != 1 ? 's' : ''}',
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _displayCheckedItems,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: manager.groupAt(widget.groupIdx).checkedLength,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) =>
                            _onTapRemoveCheckedElement(index),
                        background: Container(
                          color: Colors.transparent,
                        ),
                        secondaryBackground: Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.delete_rounded,
                              color: appTheme.theme.secondaryColor,
                            ),
                          ),
                        ),
                        child: ChecklistTile(widget.groupIdx, index, true),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onGroupTitleModified(String newTitle) {
    ChecklistManager().updateGroupTitle(widget.groupIdx, newTitle);
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

  void _onTapToggleShowCheckedItems() {
    if (_turns != 0) {
      setState(() {
        _turns = 0.0;
        _displayCheckedItems = false;
      });
    } else {
      setState(() {
        _turns = -0.5;
        _displayCheckedItems = true;
      });
    }
  }
}
