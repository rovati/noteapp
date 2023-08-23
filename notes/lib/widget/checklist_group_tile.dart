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
  var _collapsed = false;
  final TextEditingController _titleController = TextEditingController();

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
          color: appTheme.theme.noteTitleBG,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Consumer<ChecklistManager>(
          builder: (context, manager, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
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
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: _onTapToggleCollapse,
                      child: Container(
                        height: 2,
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _nbCheckedToShow(manager),
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

  void _onTapToggleCollapse() {
    setState(() {
      _collapsed = !_collapsed;
    });
  }

  int _nbCheckedToShow(manager) {
    var nbChecked = manager.groupAt(widget.groupIdx).checkedLength;
    return _collapsed && nbChecked > 0 ? 1 : nbChecked;
  }
}
