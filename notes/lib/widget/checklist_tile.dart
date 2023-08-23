import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/note/checklist_element.dart';
import '../model/note/notifier/checklist_list.dart';

class ChecklistTile extends StatefulWidget {
  final int groupIdx;
  final int elemIdx;
  final bool checked;

  const ChecklistTile(this.groupIdx, this.elemIdx, this.checked, {super.key});

  @override
  State<ChecklistTile> createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<ChecklistTile> {
  late final TextEditingController _controller = TextEditingController();
  Timer? _updateTimer;
  late ChecklistElement _element;
  late bool _ticked;

  @override
  void initState() {
    super.initState();
    _ticked = widget.checked;
    _element = ChecklistManager()
        .elem(widget.groupIdx, widget.elemIdx, widget.checked);
    _controller.text = _element.content;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChecklistManager>(builder: (context, manager, child) {
      _element = manager.elem(widget.groupIdx, widget.elemIdx, widget.checked);

      _controller.text = _element.content;
      return Row(
        children: [
          Opacity(
            opacity: _ticked ? 0.5 : 1,
            child: IconButton(
              icon: widget.checked
                  ? const Icon(Icons.check_box_rounded)
                  : const Icon(Icons.check_box_outline_blank_rounded),
              onPressed: _onTapCheckbox,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              maxLength: 100,
              maxLines: null,
              onChanged: _onContentModified,
              onSubmitted: _onContentSubmitted,
              textInputAction: TextInputAction.done,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                hintText: 'Item',
                border: InputBorder.none,
                counterText: '',
              ),
              enabled: !_ticked,
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 30))
        ],
      );
    });
  }

  void _onTapCheckbox() {
    ChecklistManager()
        .toggleElementOfGroup(widget.groupIdx, widget.elemIdx, _ticked);
    _ticked = !_ticked;
  }

  void _onContentModified(String ignored) {
    if (_updateTimer != null) {
      _updateTimer!.cancel();
    }
    _updateTimer =
        Timer(const Duration(milliseconds: 200), _contentUpdateCallback);
  }

  void _contentUpdateCallback() {
    ChecklistManager().modifyElementOfGroup(
      widget.groupIdx,
      widget.elemIdx,
      ChecklistElement(
        isChecked: _ticked,
        content: _controller.text,
      ),
    );
  }

  void _onContentSubmitted(String ignored) {
    if (_updateTimer != null) {
      _updateTimer!.cancel();
    }
    _contentUpdateCallback();
  }
}
