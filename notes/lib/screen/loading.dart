import 'package:flutter/material.dart';
import 'package:notes/model/note/notifier/main_list.dart';
import 'package:notes/model/note/plaintext.dart';
import 'package:notes/model/storage/local_db.dart';
import 'package:notes/model/storage/parse_result.dart';
import 'package:provider/provider.dart';

import '../model/storage/note_id_generator.dart';
import '../theme/app_theme.dart';
import 'main.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late ParseResult _parseResult;
  late String errorMessage;
  var recoveryButtonVisible = false;
  late void Function() recoveryButtonCallback;

  @override
  void initState() {
    super.initState();
    errorMessage = '';
    recoveryButtonCallback = () {};
    _loadNotes(context);
  }

  void _loadNotes(BuildContext context) async {
    try {
      LocalDB.getNotes().then((list) {
        _parseResult = list;
        if (_parseResult.unparsed.isNotEmpty) {
          setState(() {
            recoveryButtonVisible = true;
            errorMessage =
                'There were some errors during the parsing of some notes.\n'
                'Tap here to recover them.';
          });
          recoveryButtonCallback = _recoverNotes;
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
        }
      }).timeout(const Duration(seconds: 5));
    } catch (err) {
      setState(() {
        recoveryButtonVisible = true;
        errorMessage = 'The app is having issues parsing the notes.\n'
            'Tap here to try a recovery.';
      });
      recoveryButtonCallback = _exportNotes;
    }
  }

  void _exportNotes() {
    LocalDB.archiveNotes().then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Notes archive saved to local storage'),
        ));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Could not create the notes archive!'),
        ));
      }
    });
  }

  void _recoverNotes() {
    for (int i = 0; i < _parseResult.unparsed.length; i++) {
      IDProvider.getNextId().then((id) => NotesList().addNote(Plaintext(id,
          title: 'recovered note $i', content: _parseResult.unparsed[i])));
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainPage()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Consumer<AppTheme>(
          builder: (context, appTheme, child) => Stack(
            children: [
              appTheme.theme.background,
              SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                      scale: 3.0,
                      child: CircularProgressIndicator(
                        color: appTheme.theme.secondaryColor,
                        strokeWidth: 2.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Visibility(
                        visible: recoveryButtonVisible,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextButton(
                            onPressed: recoveryButtonCallback,
                            child: Text(
                              errorMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: appTheme.theme.secondaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
