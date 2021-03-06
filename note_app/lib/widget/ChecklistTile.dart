import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_app/model/checklist/ChecklistElement.dart';
import 'package:note_app/model/checklist/ChecklistManager.dart';
import 'package:provider/provider.dart';

class ChecklistTile extends StatefulWidget {
  final int idx;

  ChecklistTile(this.idx);

  @override
  _ChecklistTileState createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<ChecklistTile> {
  late TextEditingController _controller = TextEditingController();
  late bool _ticked = false;
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    _controller.text = ChecklistManager().elems[widget.idx].content;
    _ticked = ChecklistManager().elems[widget.idx].isChecked;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChecklistManager>(builder: (context, manager, child) {
      _controller.text = manager.elems[widget.idx].content;
      _ticked = manager.elems[widget.idx].isChecked;
      return Row(
          children: [
            IconButton(
            icon: _ticked
                ? Icon(Icons.check_box_rounded)
                : Icon(Icons.check_box_outline_blank_rounded),
            onPressed: _onTapCheckbox,
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLength: 100,
                maxLines: null,
                onChanged: _onContentModified,
                onSubmitted: _onContentSubmitted,
                textInputAction: TextInputAction.done,
                style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                  hintText: 'Item',
                  border: InputBorder.none,
                  counterText: '',
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 30))
          ],
      );
    });
  }

  void _onTapCheckbox() {
    setState(() {
      _ticked = !_ticked;
    });
    ChecklistManager().modifyElement(
        widget.idx,
        ChecklistElement(
          isChecked: _ticked,
          content: _controller.text,
        ));
  }

  void _onContentModified(String ignored) {
    if (_updateTimer != null) {
      _updateTimer!.cancel();
    }
    _updateTimer = Timer(Duration(milliseconds: 200), _contentUpdateCallback);
  }

  void _contentUpdateCallback() {
    ChecklistManager().modifyElement(
        widget.idx,
        ChecklistElement(
          isChecked: _ticked,
          content: _controller.text,
        ));
  }

  void _onContentSubmitted(String ignored) {
    if (_updateTimer != null) {
      _updateTimer!.cancel();
    }
    _contentUpdateCallback();
  }
}
