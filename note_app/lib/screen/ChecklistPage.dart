import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/model/checklist/Checklist.dart';
import 'package:note_app/util/constant/app_theme.dart';
import 'package:note_app/widget/DismissibleChecklist.dart';

class ChecklistPage extends StatefulWidget {
  final int noteID;

  ChecklistPage({required this.noteID});

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  TextEditingController _titleController = new TextEditingController();
  late var note;
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    note = NotesList().getNoteWithID(widget.noteID);
    _titleController.text = note.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Themes.background,
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Container(
                      child: TextField(
                        readOnly: note.id == -1,
                        onChanged: (text) {
                          if (text.length > 50) {
                            setState(() {
                              _titleController.text = text.substring(0, 50);
                            });
                          }
                          _onNoteModified('');
                        },
                        maxLines: null,
                        controller: _titleController,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Note title',
                          border: InputBorder.none,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.85,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 5.0),
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 12.0,
                          color: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: DismissibleChecklist(note),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onNoteModified(String ignore) {
    if (_updateTimer != null) {
      _updateTimer!.cancel();
    }
    _updateTimer = Timer(Duration(milliseconds: 200), _updateCallback);
  }

  void _updateCallback() {
    final modifiedNote = Checklist(widget.noteID, title: _titleController.text);
    NotesList().modifyNote(modifiedNote);
  }
}
