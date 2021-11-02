import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_app/model/checklist/ChecklistManager.dart';
import 'package:note_app/util/constant/app_theme.dart';
import 'package:note_app/widget/DismissibleChecklist.dart';

class ChecklistPage extends StatefulWidget {
  ChecklistPage();

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  TextEditingController _titleController = new TextEditingController();
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    _titleController.text = ChecklistManager().title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Themes.background,
          Scaffold(
        backgroundColor: Colors.transparent,
        body: 
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Container(
                      child: TextField(
                        readOnly: ChecklistManager().id == -1,
                        onChanged: _onTitleModified,
                        maxLines: null,
                        maxLength: 50,
                        textInputAction: TextInputAction.done,
                        controller: _titleController,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                        decoration: InputDecoration(
                          hintText: 'Note title',
                          border: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.85,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Themes.tileBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: DismissibleChecklist(),
                  ),
                ),
              ],
            ),
          ),),
        ],
      ),
    );
  }

  void _onTitleModified(String ignore) {
    if (_updateTimer != null) {
      _updateTimer!.cancel();
    }
    _updateTimer = Timer(Duration(milliseconds: 200), _titleUpdateCallback);
  }

  void _titleUpdateCallback() {
    ChecklistManager().setTitle(_titleController.text);
  }
}
