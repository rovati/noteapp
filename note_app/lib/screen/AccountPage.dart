import 'package:flutter/material.dart';
import 'package:note_app/util/constant/app_theme.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Themes.background,
          ],
        ),
      );
}
