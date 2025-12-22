import 'package:flutter/material.dart';
import 'package:notes/screen/sync.dart';
import 'package:provider/provider.dart';

import '../model/note/checklist.dart';
import '../model/note/notifier/main_list.dart';
import '../model/note/plaintext.dart';
import '../model/storage/note_id_generator.dart';
import '../screen/settings.dart';
import '../theme/app_theme.dart';
import '../util/app_values.dart';

// idea:
// wrap everything in sizetransition
// keep full column with buttons at constant size and right background color
// stack top an animated container with just shadow that follows the sizetransition
// problem: how to hide curved part?

class SunkenToolbar extends StatefulWidget {
  const SunkenToolbar({super.key});

  @override
  State<SunkenToolbar> createState() => _SunkenToolbarState();
}

class _SunkenToolbarState extends State<SunkenToolbar>
    with TickerProviderStateMixin {
  final double _width = 70.0;
  final _height = 325.0;
  late Animation<double> animation;
  late AnimationController _controller;
  late AnimationController _rotation;
  double _turns = 0;
  late Color _exportIconColor;
  late Color _checklistIconColor;
  late Color _plaintextIconColor;
  late Color _tapColor;

  @override
  void initState() {
    super.initState();

    _exportIconColor = AppTheme().theme.secondaryColor;
    _checklistIconColor = AppTheme().theme.secondaryColor;
    _plaintextIconColor = AppTheme().theme.secondaryColor;
    _tapColor = AppTheme().theme.toolbarIconTapColor;

    _rotation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    animation = Tween<double>(begin: _height - _width, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));
  }

  @override
  void dispose() {
    _rotation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, child) => Container(
        alignment: Alignment.bottomRight,
        height: _height + MediaQuery.of(context).padding.bottom,
        width: _width,
        child: AnimatedBuilder(
          animation: animation,
          child: buttonsColumn(appTheme),
          builder: (context, child) {
            return ClipPath(
              clipper: RoundedClipper(
                  _width,
                  _height + MediaQuery.of(context).padding.bottom,
                  animation.value),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AbsorbPointer(
                    absorbing: true,
                    child: Container(
                      height: _height +
                          MediaQuery.of(context).padding.bottom -
                          animation.value,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35)),
                        boxShadow: [
                          BoxShadow(
                            color: appTheme.theme.toolbarShade,
                          ),
                          BoxShadow(
                            color: appTheme.theme.toolbarBG,
                            blurRadius: 6.0,
                            offset: const Offset(6, 6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child!,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buttonsColumn(AppTheme appTheme) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: IconButton(
              onPressed: _onTapOpenSync,
              icon: Icon(
                Icons.sync,
                color: _exportIconColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: IconButton(
              onPressed: _onTapOpenSettings,
              icon: Icon(
                Icons.settings_rounded,
                color: appTheme.theme.secondaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: IconButton(
              onPressed: _onTapNewChecklist,
              icon: Icon(
                Icons.check_box_rounded,
                color: _checklistIconColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: IconButton(
              onPressed: _onTapNewPlainNote,
              icon: Icon(
                Icons.dehaze_rounded,
                color: _plaintextIconColor,
              ),
            ),
          ),
          Container(
            width: _width * 0.6,
            height: _height * 0.01,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              color: appTheme.theme.secondaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: IconButton(
              onPressed: _onTapArrow,
              icon: AnimatedRotation(
                turns: _turns,
                duration: const Duration(milliseconds: 250),
                child: const Icon(Icons.keyboard_arrow_up_rounded),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      );

  void _onTapArrow() {
    if (_controller.status != AnimationStatus.reverse &&
        _controller.status != AnimationStatus.forward) {
      if (animation.value == 0) {
        // close toolbar
        setState(() {
          _turns = 0.0;
        });
        _controller.reverse();
      } else {
        // open toolbar
        setState(() {
          _turns = -0.5;
        });
        _controller.forward();
      }
    }
  }

  void _onTapNewPlainNote() {
    if (NotesList().notes.length < Values.maxNotes) {
      IDProvider.getNextId().then((id) => NotesList().addNote(Plaintext(id)));
      setState(() {
        _plaintextIconColor = _tapColor;
      });
      Future.delayed(
          const Duration(milliseconds: 500),
          () => setState(() {
                _plaintextIconColor = AppTheme().theme.secondaryColor;
              }));
    } else {
      showNotesFullSnackbar();
    }
  }

  void _onTapNewChecklist() {
    if (NotesList().notes.length < Values.maxNotes) {
      IDProvider.getNextId().then((id) => NotesList().addNote(Checklist(id)));
      setState(() {
        _checklistIconColor = _tapColor;
      });
      Future.delayed(
          const Duration(milliseconds: 500),
          () => setState(() {
                _checklistIconColor = AppTheme().theme.secondaryColor;
              }));
    } else {
      showNotesFullSnackbar();
    }
  }

  void _onTapOpenSettings() {
    _onTapArrow();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsPage()));
  }

  void _onTapOpenSync() {
    _onTapArrow();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SyncPage()));
  }

  void showNotesFullSnackbar() {
    SnackBar snack = const SnackBar(
      showCloseIcon: true,
      content: Text('There already are too many notes!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

class RoundedClipper extends CustomClipper<Path> {
  final double height;
  final double width;
  final double animVal;

  RoundedClipper(this.width, this.height, this.animVal);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, height);
    path.lineTo(width, height);
    path.lineTo(width, animVal);
    path.lineTo(width / 2, animVal);
    path.quadraticBezierTo(
      0,
      animVal,
      0,
      animVal + width / 2,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
