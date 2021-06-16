import 'package:flutter/material.dart';
import 'package:note_app/util/constant/app_theme.dart';
import 'dart:math' show pi;

class Toolbar extends StatefulWidget {
  @override
  _ToolbarState createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  var _width = 70.0;
  var _angle = 0.0;
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 70,
      width: _width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: Themes.red,
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutQuad,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: _visible,
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.info_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_rounded),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                border: Border.all(
                  color: Colors.grey.shade800,
                  width: 2,
                )),
            child: InkWell(
              onTap: _onTap,
              borderRadius: BorderRadius.circular(35),
              highlightColor: Themes.red,
              child: Transform.rotate(
                  angle: _angle,
                  child: Icon(Icons.keyboard_arrow_left_rounded)),
            ),
          ),
        ],
      ),
    );
  }

  void _onTap() {
    setState(() {
      _width = _width == 70.0 ? MediaQuery.of(context).size.width - 30.0 : 70.0;
      _angle = _angle == 0.0 ? pi : 0.0;
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
}
