import 'package:flutter/material.dart';
import 'package:note_app/util/DatabaseHelper.dart';
import 'package:note_app/util/constant/app_theme.dart';

class RecoveryPage extends StatelessWidget {
  final Future<List<String>> _notes = DatabaseHelper.recoverNotes();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Themes.background,
            Center(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.90,
                child: unparsedList(context),
              ),
            ),
          ],
        ),
      );

  Widget unparsedList(BuildContext context) => FutureBuilder<List<String>>(
      future: _notes,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snap) {
        if (snap.hasData) {
          final list = snap.data;
          if (list != null)
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(list[index]),
                  );
                });
          else
            return Text('Data is null!');
        } else
          return SizedBox();
      });
}
