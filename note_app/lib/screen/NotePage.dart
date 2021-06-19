import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_app/model/Note.dart';
import 'package:note_app/model/NotesList.dart';

class NotePage extends StatefulWidget {
  final int noteID;

  NotePage({required this.noteID});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                            color: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54)))),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                onChanged: _onNoteModified,
                readOnly: note.id == -1,
                maxLines: null,
                controller: _bodyController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration.collapsed(
                  hintText: 'New note',
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
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
    final modifiedNote = Note(widget.noteID, _titleController.text,
        content: _bodyController.text);
    NotesList().modifyNote(modifiedNote);
  }
}
