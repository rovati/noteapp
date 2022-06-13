import 'package:flutter/material.dart';
import 'package:note_app/util/DatabaseHelper.dart';
import 'package:note_app/util/ParseResult.dart';
import 'package:note_app/util/constant/app_theme.dart';

import 'MainPage.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final Future<ParseResult> _res = DatabaseHelper.getNotes();

  void navigateWhenComplete(BuildContext context) async {
    Future.delayed(
        Duration(milliseconds: 200),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Themes.background,
          Center(
            child: FutureBuilder<ParseResult>(
              future: _res,
              builder: (BuildContext context, AsyncSnapshot<ParseResult> snap) {
                if (!snap.hasData) {
                  return Transform.scale(
                    scale: 3.0,
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
                      strokeWidth: 2.0,
                    ),
                  );
                } else {
                  if (snap.data != null && snap.data!.unparsed.isEmpty) {
                    navigateWhenComplete(context);
                    return Text('Loaded!');
                  }
                  if (snap.data != null) {
                    return unparsedNotesBox(context, snap.data!.unparsed);
                  }
                  return Text('Error!');
                }
              },
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
          children: [
            ListView.builder(
              itemCount: unparsed.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(top: 6, bottom: 6),
                child: Text(unparsed[index]),
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
