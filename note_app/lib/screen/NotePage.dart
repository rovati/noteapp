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
                      },
                      onEditingComplete: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
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
                readOnly: note.id == -1,
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
}
