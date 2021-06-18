import 'package:flutter/material.dart';
import 'package:note_app/model/Note.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/util/IDProvider.dart';
import 'package:note_app/util/constant/app_theme.dart';
import 'dart:math' show pi;

class Toolbar extends StatefulWidget {
  @override
  _ToolbarState createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> with TickerProviderStateMixin {
  final double iconSize = 70;
  late var _height;
  var _angle = 0.0;
  bool _visible = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _height = iconSize;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _height,
      width: iconSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(iconSize / 2),
        color: Themes.red,
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutQuad,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: _visible,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.info_rounded),
                  ),
                  IconButton(
                    onPressed: _onTapNewNote,
                    icon: Icon(Icons.add_rounded),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(iconSize / 2),
                border: Border.all(
                  color: Colors.grey.shade800,
                  width: 2,
                )),
            child: InkWell(
              onTap: _onTapArrow,
              borderRadius: BorderRadius.circular(iconSize / 2),
              highlightColor: Themes.red,
              child: Transform.rotate(
                  angle: _controller.value * pi * -1,
                  child: Icon(Icons.keyboard_arrow_up_rounded)),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapArrow() {
    setState(() {
      _height =
          _height != iconSize ? iconSize : (iconSize * 3 + 2 * iconSize * 0.1);
      _angle = _angle == 0.0 ? pi : 0.0;
      if (_controller.isCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      if (_visible) {
        _visible = !_visible;
      } else {
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            _visible = !_visible;
          });
        });
      }
    });
  }

  void _onTapNewNote() {
    IDProvider.getNextId().then(
        (id) => NotesList().addNote(Note(id, 'New note ' + id.toString())));
  }
}
