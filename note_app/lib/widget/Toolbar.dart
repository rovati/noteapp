import 'package:flutter/material.dart';
import 'package:note_app/model/Plaintext.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/screen/InfoPage.dart';
import 'package:note_app/util/IDProvider.dart';
import 'package:note_app/util/constant/app_theme.dart';
import 'dart:math' show pi;

import 'package:note_app/util/constant/app_values.dart';

class Toolbar extends StatefulWidget {
  @override
  _ToolbarState createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> with TickerProviderStateMixin {
  final double iconSize = 70;
  late var _height;
  bool _infoVisible = false;
  bool _addPlainVisible = false;
  bool _addCheckVisible = false;
  double _infoOpacity = 0.0;
  double _addPlainOpacity = 0.0;
  double _addCheckOpacity = 0.0;
  late AnimationController _controller;
  var isAnimating = false;

  @override
  void initState() {
    super.initState();
    _height = iconSize;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
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
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOutQuad,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: _infoVisible,
                  child: AnimatedOpacity(
                    opacity: _infoOpacity,
                    duration: Duration(milliseconds: 150),
                    child: IconButton(
                      onPressed: _onTapOpenInfo,
                      icon: Icon(Icons.info_rounded),
                    ),
                  ),
                ),
                Visibility(
                  visible: _addCheckVisible,
                  child: AnimatedOpacity(
                    opacity: _addCheckOpacity,
                    duration: Duration(milliseconds: 150),
                    child: IconButton(
                      onPressed: _onTapNewChecklist,
                      icon: Icon(Icons.check_box_rounded),
                    ),
                  ),
                ),
                Visibility(
                  visible: _addPlainVisible,
                  child: AnimatedOpacity(
                    opacity: _addPlainOpacity,
                    duration: Duration(milliseconds: 150),
                    child: IconButton(
                      onPressed: _onTapNewPlainNote,
                      icon: Icon(Icons.add_rounded),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(iconSize / 2),
                border: Border.all(
                  color: Themes.grey,
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
    if (!isAnimating) {
      if (_height != iconSize) {
        closeToolbar();
      } else {
        openToolbar();
      }
    }
  }

  void closeToolbar() {
    isAnimating = true;
    setState(() {
      _infoOpacity = 0.0;
      _controller.reverse();
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _addCheckOpacity = 0.0;
      });
    });
    Future.delayed(Duration(milliseconds: 150), () {
      setState(() {
        _addPlainOpacity = 0.0;
      });
    });
    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        _infoVisible = false;
        _addCheckVisible = false;
        _addPlainVisible = false;
        _height = iconSize;
      });
      isAnimating = false;
    });
  }

  void openToolbar() {
    isAnimating = true;
    setState(() {
      _height = (iconSize * 4 + 3 * iconSize * 0.1);
      _controller.forward();
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _addPlainVisible = true;
        _addCheckVisible = true;
        _infoVisible = true;
        _addPlainOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        _addCheckOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _infoOpacity = 1.0;
      });
      isAnimating = false;
    });
  }

  void _onTapNewPlainNote() {
    if (NotesList().notes.length < Values.MAX_NOTES) {
      IDProvider.getNextId().then((id) => NotesList().addNote(Plaintext(id)));
    }
  }

  void _onTapNewChecklist() {}

  void _onTapOpenInfo() {
    _onTapArrow();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InfoPage()));
  }
}
