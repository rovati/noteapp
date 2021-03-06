import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_app/model/Plaintext.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/util/constant/app_theme.dart';

class PlaintextPage extends StatefulWidget {
  final int noteID;

  PlaintextPage({required this.noteID});

  @override
  _PlaintextPageState createState() => _PlaintextPageState();
}

class _PlaintextPageState extends State<PlaintextPage> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _bodyController = new TextEditingController();
  late var note;
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    note = NotesList().getNoteWithID(widget.noteID);
    _titleController.text = note.title;
    _bodyController.text = note.content;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    if (_updateTimer != null) {
      _updateTimer!.cancel();
    }
    super.dispose();
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
            body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Container(
                        child: TextField(
                          readOnly: note.id == -1,
                          onChanged: _onNoteModified,
                          maxLines: null,
                          maxLength: 50,
                          controller: _titleController,
                          textInputAction: TextInputAction.done,
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
                    padding: EdgeInsets.all(20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Themes.plaintextBg,
                          ),
                        ),
                        FractionallySizedBox(
                          alignment: Alignment.center,
                          widthFactor: 0.95,
                          heightFactor: 0.95,
                          child: TextField(
                            onChanged: _onNoteModified,
                            readOnly: note.id == -1,
                            maxLines: null,
                            textInputAction: TextInputAction.newline,
                            controller: _bodyController,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration.collapsed(
                              hintText: 'New note',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),),
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
    final modifiedNote = Plaintext(widget.noteID,
        title: _titleController.text,
        content: _bodyController.text,
        pinned: NotesList().getNoteWithID(widget.noteID).pinned);
    NotesList().modifyNote(modifiedNote);
  }
}
