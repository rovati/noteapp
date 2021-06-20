import 'package:flutter/material.dart';
import 'package:note_app/widget/DismissibleNotes.dart';
import 'dart:math' show pi;

import 'package:note_app/widget/Toolbar.dart';

/// Shows the list of notes and a bar that allows to create notes and access the
/// settings page, plus other thingies
class MainPage extends StatefulWidget {
  MainPage({key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.90,
              child: DismissibleNotes(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 15, right: 15),
              child: Toolbar(),
            ),
          )
        ],
      ),
    );
  }
}
