import 'package:flutter/material.dart';
import 'package:notes/theme/themes.dart';

class ThemeTile extends StatelessWidget {
  final AppThemeData theme;

  const ThemeTile(this.theme, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme.toolbarShade,
              blurRadius: 2,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            theme.background,
            Padding(
              padding: const EdgeInsets.only(
                  left: 60, right: 60, top: 10, bottom: 10),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme.noteTitleBG,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  theme.name,
                  style: TextStyle(color: theme.secondaryColor),
                ),
              ),
            ),
          ],
        ),
      );
}
