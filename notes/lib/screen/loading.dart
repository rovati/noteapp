import 'package:flutter/material.dart';
import 'package:notes/model/storage/local_db.dart';
import 'package:notes/model/storage/parse_result.dart';

import '../theme/app_theme.dart';
import 'main.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late ParseResult _parseResult;
  bool _loaderVisible = false;
  bool _recoveryTextVisible = false;
  bool _recoveredNotesVisible = false;
  double _loaderOpacity = 1.0;
  double _recoveryTextOpacity = 0.0;
  double _recoveredNotesOpacity = 0.0;

  void loadNotes(BuildContext context) async {
    LocalDB.getNotes().then((list) {
      _parseResult = list;
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    }).timeout(const Duration(seconds: 5), onTimeout: _switchWidgets);
  }

  void _switchWidgets() {
    _loaderOpacity = 0.0;
    Future.delayed(const Duration(milliseconds: 200), () {
      _loaderVisible = false;
      _recoveryTextVisible = true;
      _recoveryTextOpacity = 1.0;
    });
  }

  void _showRecoveredNotes() {
    _recoveryTextOpacity = 0.0;
    Future.delayed(const Duration(milliseconds: 200), () {
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
                  duration: const Duration(milliseconds: 200),
                  child: Visibility(
                    visible: _loaderVisible,
                    child: Center(
                      child: Transform.scale(
                        scale: 3.0,
                        child: const CircularProgressIndicator(
                          color: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
                          strokeWidth: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _recoveryTextOpacity,
                  duration: const Duration(milliseconds: 200),
                  child: Visibility(
                    visible: _recoveryTextVisible,
                    child: Center(
                      child: TextButton(
                        child: const Text(
                            'The app is having issues parsing the notes.\nTap here to try a recovery.'),
                        onPressed: () => _showRecoveredNotes,
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _recoveredNotesOpacity,
                  duration: const Duration(milliseconds: 200),
                  child: Visibility(
                    visible: _recoveredNotesVisible,
                    child: _parseResult != null
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: _parseResult.unparsed.length + 1,
                              itemBuilder: (context, index) => index !=
                                      _parseResult.unparsed.length
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 6, bottom: 6),
                                      child: Text(_parseResult.unparsed[index]),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: TextButton(
                                        child: const Text('OK'),
                                        onPressed: () => MaterialPageRoute(
                                          builder: (context) =>
                                              const MainPage(),
                                        ),
                                      ),
                                    ),
                            ),
                          )
                        : Center(
                            child: TextButton(
                              child: const Text('OK'),
                              onPressed: () => MaterialPageRoute(
                                builder: (context) => const MainPage(),
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
