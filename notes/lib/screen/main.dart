import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widget/dimsissible_notes.dart';
import '../widget/sunken_toolbar.dart';

/// Shows the list of notes and a bar that allows to create notes and access the
/// settings page, plus other thingies
class MainPage extends StatelessWidget {
  const MainPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppTheme().theme.background,
          Center(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.90,
              child: const DismissibleNotes(),
            ),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: SunkenToolbar(),
          )
        ],
      ),
    );
  }
}
