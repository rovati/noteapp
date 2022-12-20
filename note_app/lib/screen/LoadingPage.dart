import 'package:flutter/material.dart';
import 'package:note_app/util/DatabaseHelper.dart';
import 'package:note_app/util/constant/app_theme.dart';

import 'MainPage.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  var _parseResult;
  var _loaderVisible;
  var _recoveryTextVisible;
  var _loaderOpacity;
  var _recoveryTextOpacity;
  var _recoveredNotesVisible;
  var _recoveredNotesOpacity;

  @override
  void initState() {
    super.initState();
    _loaderOpacity = 1.0;
    _loaderVisible = true;
    _recoveryTextOpacity = 0.0;
    _recoveryTextVisible = false;
    _recoveredNotesOpacity = 0.0;
    _recoveredNotesVisible = false;
  }

  void loadNotes(BuildContext context) async {
    DatabaseHelper.getNotes()
        .then((list) {
          _parseResult = list;
          return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage()));
        })
        .timeout(Duration(seconds: 5), onTimeout: _switchWidgets);
  }

  void _switchWidgets() {
    _loaderOpacity = 0.0;
    Future.delayed(Duration(milliseconds: 200), () {
      _loaderVisible = false;
      _recoveryTextVisible = true;
      _recoveryTextOpacity = 1.0;
    });
  }

  void _showRecoveredNotes() {
    _recoveryTextOpacity = 0.0;
    Future.delayed(Duration(milliseconds: 200), () {
      _recoveryTextVisible = false;
      _recoveredNotesVisible = true;
      _recoveredNotesOpacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadNotes(context);
    return Scaffold(
      body: Stack(
        children: [
          Themes.background,
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _loaderOpacity,
                  duration: Duration(milliseconds: 200),
                  child: Visibility(
                    visible: _loaderVisible,
                    child: Center(
                      child: Transform.scale(
                        scale: 3.0,
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
                          strokeWidth: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _recoveryTextOpacity,
                  duration: Duration(milliseconds: 200),
                  child: Visibility(
                    visible: _recoveryTextVisible,
                    child: Center(
                      child: TextButton(
                        child: Text('The app is having issues parsing the notes.\nTap here to try a recovery.'),
                        onPressed: () => _showRecoveredNotes,
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _recoveredNotesOpacity,
                  duration: Duration(milliseconds: 200),
                  child: Visibility(
                    visible: _recoveredNotesVisible,
                    child: _parseResult != null ?
                      Expanded(
                        child: ListView.builder(
                          itemCount: _parseResult.unparsed + 1,
                          itemBuilder: (context, index) =>
                            index != _parseResult.unparsed.size() ? 
                              Padding(
                                padding: EdgeInsets.only(top: 6, bottom: 6),
                                child: Text(_parseResult.unparsed[index]),
                              ) : 
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: TextButton(
                                  child: Text('OK'),
                                  onPressed: () => MaterialPageRoute(builder: (context) => MainPage(),
                                  ),
                                ),
                              ),
                        ),
                      ) :
                      Center(
                        child: TextButton(
                          child: Text('OK'),
                          onPressed: () => MaterialPageRoute(builder: (context) => MainPage(),
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
    );
  }

}
