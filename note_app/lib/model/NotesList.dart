import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesList extends ChangeNotifier {
  static final NotesList _list = NotesList._internal();

  factory NotesList() {
    return _list;
  }

  NotesList._internal() {
    // init here the list
  }
}
