import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<AppTheme>(
        builder: (context, appTheme, child) => Stack(
          children: [
            appTheme.theme.background,
            Center(
              child: Container(
                alignment: Alignment.center,
                child: const DismissibleNotes(),
              ),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: SunkenToolbar(),
            )
          ],
        ),
      ),
    );
  }
}
