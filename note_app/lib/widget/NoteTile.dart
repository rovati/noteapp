import 'package:flutter/material.dart';

class NoteTile extends StatefulWidget {
  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          //color: Colors.transparent,
          gradient: LinearGradient(colors: [
            Color.fromARGB(0x55, 0xC1, 0xC1, 0xC1),
            Color.fromARGB(0x01, 0xC1, 0xC1, 0xC1)
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),

          border: Border.all(
            color: Color.fromARGB(0xAA, 0xE1, 0x55, 0x54),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          onTap: () {},
          leading: Icon(Icons.dehaze_outlined),
          title: Text('New note'),
        ));
  }
}
