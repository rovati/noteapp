import 'package:flutter/material.dart';
import 'package:notes/model/storage/local_db.dart';
import 'dart:math' show pi;

import '../model/note/checklist.dart';
import '../model/note/notifier/main_list.dart';
import '../model/note/plaintext.dart';
import '../model/storage/note_id_generator.dart';
import '../screen/info.dart';
import '../theme/app_theme.dart';
import '../util/app_values.dart';

class SunkenToolbar extends StatefulWidget {
  const SunkenToolbar({super.key});

  @override
  State<SunkenToolbar> createState() => _SunkenToolbarState();
}

class _SunkenToolbarState extends State<SunkenToolbar>
    with TickerProviderStateMixin {
  final double iconSize = 70;
  late double _height;
  bool _downloadVisible = false;
  bool _infoVisible = false;
  bool _addPlainVisible = false;
  bool _addCheckVisible = false;
  double _downloadOpacity = 0.0;
  double _infoOpacity = 0.0;
  double _addPlainOpacity = 0.0;
  double _addCheckOpacity = 0.0;
  late AnimationController _controller;
  var isAnimating = false;

  @override
  void initState() {
    super.initState();
    _height = iconSize;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
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
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(iconSize / 2)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
            ),
            BoxShadow(
              color: Themes.lightGrey,
              blurRadius: 6.0,
              offset: Offset(6, 6),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutQuad,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: _downloadVisible,
                        child: AnimatedOpacity(
                          opacity: _downloadOpacity,
                          duration: const Duration(milliseconds: 150),
                          child: IconButton(
                            onPressed: _onTapDownload,
                            icon: const Icon(Icons.download),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _infoVisible,
                        child: AnimatedOpacity(
                          opacity: _infoOpacity,
                          duration: const Duration(milliseconds: 150),
                          child: IconButton(
                            onPressed: _onTapOpenInfo,
                            icon: const Icon(Icons.info_rounded),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _addCheckVisible,
                        child: AnimatedOpacity(
                          opacity: _addCheckOpacity,
                          duration: const Duration(milliseconds: 150),
                          child: IconButton(
                            onPressed: _onTapNewChecklist,
                            icon: const Icon(Icons.check_box_rounded),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _addPlainVisible,
                        child: AnimatedOpacity(
                          opacity: _addPlainOpacity,
                          duration: const Duration(milliseconds: 150),
                          child: IconButton(
                            onPressed: _onTapNewPlainNote,
                            icon: const Icon(Icons.dehaze_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: iconSize,
                  height: iconSize,
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(iconSize / 2),
                  //     border: Border.all(
                  //       color: Themes.tileBg,
                  //       width: 2,
                  //     )),
                  child: InkWell(
                    onTap: _onTapArrow,
                    borderRadius: BorderRadius.circular(iconSize / 2),
                    highlightColor: Themes.red,
                    child: Transform.rotate(
                        angle: _controller.value * pi * -1,
                        child: const Icon(Icons.keyboard_arrow_up_rounded)),
                  ),
                ),
              ],
            ),
          ],
        ));
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
      _downloadOpacity = 0.0;
      _controller.reverse();
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _infoOpacity = 0.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _addCheckOpacity = 0.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        _addPlainOpacity = 0.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 250), () {
      setState(() {
        _downloadVisible = false;
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
      _height = (iconSize * 5 + 3 * iconSize * 0.1);
      _controller.forward();
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _addPlainVisible = true;
        _addCheckVisible = true;
        _infoVisible = true;
        _downloadVisible = true;
        _addPlainOpacity = 1.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 250), () {
      setState(() {
        _addCheckOpacity = 1.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _infoOpacity = 1.0;
      });
      isAnimating = false;
    });
    Future.delayed(const Duration(milliseconds: 350), () {
      setState(() {
        _downloadOpacity = 1.0;
      });
      isAnimating = false;
    });
  }

  void _onTapNewPlainNote() {
    if (NotesList().notes.length < Values.maxNotes) {
      IDProvider.getNextId().then((id) => NotesList().addNote(Plaintext(id)));
    } else {
      showNotesFullSnackbar();
    }
  }

  void _onTapNewChecklist() {
    if (NotesList().notes.length < Values.maxNotes) {
      IDProvider.getNextId().then((id) => NotesList().addNote(Checklist(id)));
    } else {
      showNotesFullSnackbar();
    }
  }

  void _onTapOpenInfo() {
    _onTapArrow();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InfoPage()));
  }

  void _onTapDownload() {
    // TODO add check whether we are already zipping
    SnackBar snack;

    LocalDB.archiveNotes().then((res) {
      if (res) {
        snack = const SnackBar(
          content: Text('Notes archive saved to local storage'),
        );
      } else {
        snack = const SnackBar(
          content: Text('Could not create the notes archive!'),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(snack);
    });
  }

  void showNotesFullSnackbar() {
    SnackBar snack = const SnackBar(
      content: Text('There already are too many notes!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
