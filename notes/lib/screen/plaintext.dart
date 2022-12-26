import 'dart:async';

import 'package:flutter/material.dart';

import '../model/note/notifier/main_list.dart';
import '../model/note/plaintext.dart';
import '../theme/app_theme.dart';
import '../theme/themes.dart';

class PlaintextPage extends StatefulWidget {
  final int noteID;

  const PlaintextPage({super.key, required this.noteID});

  @override
  State<PlaintextPage> createState() => _PlaintextPageState();
}

class _PlaintextPageState extends State<PlaintextPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  late Plaintext note;
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    note = NotesList().getNoteWithID(widget.noteID) as Plaintext;
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
          AppTheme().theme.background,
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme().theme.semiTransparentBG,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          readOnly: note.id == -1,
                          onChanged: _onNoteModified,
                          maxLines: null,
                          maxLength: 50,
                          controller: _titleController,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24),
                          decoration: const InputDecoration(
                            hintText: 'Note title',
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppTheme().theme.semiTransparentBG,
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
                              style: const TextStyle(fontSize: 20),
                              decoration: const InputDecoration.collapsed(
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
    _updateTimer = Timer(const Duration(milliseconds: 200), _updateCallback);
  }

  void _updateCallback() {
    final modifiedNote = Plaintext(widget.noteID,
        title: _titleController.text,
        content: _bodyController.text,
        pinned: NotesList().getNoteWithID(widget.noteID).pinned);
    NotesList().modifyNote(modifiedNote);
  }
}
