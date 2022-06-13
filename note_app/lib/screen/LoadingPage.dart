import 'package:flutter/material.dart';
import 'package:note_app/util/DatabaseHelper.dart';
import 'package:note_app/util/ParseResult.dart';
import 'package:note_app/util/constant/app_theme.dart';

import 'MainPage.dart';
import 'RecoveryPage.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final Future<ParseResult> _res = DatabaseHelper.getNotes();
  final Future<bool> _timeout = Future<bool>.delayed(
    const Duration(seconds: 5),
    () => true,
  );

  void navigateWhenComplete(BuildContext context) async {
    Future.delayed(
        Duration(milliseconds: 200),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage())));
  }

  void navigateToRecovery(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => RecoveryPage()));
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: FutureBuilder<ParseResult>(
                    future: _res,
                    builder: (BuildContext context,
                        AsyncSnapshot<ParseResult> snap) {
                      if (!snap.hasData) {
                        return Center(
                          child: Transform.scale(
                            scale: 3.0,
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
                              strokeWidth: 2.0,
                            ),
                          ),
                        );
                      } else {
                        if (snap.data != null && snap.data!.unparsed.isEmpty) {
                          return Center(
                            child: Transform.scale(
                              scale: 3.0,
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
                                strokeWidth: 2.0,
                              ),
                            ),
                          );
                          /* navigateWhenComplete(context);
                        return Text('Loaded!'); */
                        }
                        if (snap.data != null) {
                          return unparsedNotesBox(context, snap.data!.unparsed);
                        }
                        return Text('Error!');
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: FutureBuilder<bool>(
                      future: _timeout,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snap) {
                        if (snap.hasData && snap.data!)
                          return Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Center(
                              child: TextButton(
                                child: Text(
                                  'Access local files',
                                  style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ),
                                onPressed: () => navigateToRecovery(context),
                              ),
                            ),
                          );
                        else
                          return SizedBox();
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget unparsedNotesBox(BuildContext context, List<String> unparsed) =>
      Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: unparsed.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(top: 6, bottom: 6),
                  child: Text(unparsed[index]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextButton(
                child: Text('OK'),
                onPressed: () => navigateWhenComplete(context),
              ),
            ),
          ],
        ),
      );
}
