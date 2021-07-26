import 'package:flutter/material.dart';
import 'package:note_app/model/checklist/ChecklistElement.dart';

class ChecklistTile extends StatefulWidget {
  final ChecklistElement noteEl;

  ChecklistTile(this.noteEl);

  @override
  _ChecklistTileState createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<ChecklistTile> {
  late TextEditingController _controller =
      TextEditingController(text: widget.noteEl.content);
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.check_box_outline_blank_rounded),
      title: TextField(
        controller: _controller,
        maxLength: 100,
        maxLines: null,
        //onEditingComplete: () => _onSubmitted(idx),
        textInputAction: TextInputAction.done,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: 'Item',
          border: InputBorder.none,
          counterText: '',
        ),
      ),
      //minVerticalPadding: 20,
      horizontalTitleGap: 0,
    );
  }

// Icons.check_box_outline_blank_rounded
}
