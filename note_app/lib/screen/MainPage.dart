import 'package:flutter/material.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/util/constant/app_theme.dart';
import 'package:note_app/widget/NoteTile.dart';
import 'dart:math' show pi;

import 'package:note_app/widget/Toolbar.dart';
import 'package:provider/provider.dart';

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
              child: Consumer<NotesList>(
                builder: (context, noteslist, child) => ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 12);
                    },
                    itemCount: noteslist.notes.length,
                    itemBuilder: (context, index) =>
                        NoteTile(noteslist.notes[index].id)),
              ),
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
