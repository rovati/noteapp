import 'package:flutter/material.dart';

import '../checklist.dart';
import '../checklist_element.dart';
import 'main_list.dart';

class ChecklistManager extends ChangeNotifier {
  static final ChecklistManager _manager = ChecklistManager._internal();
  late int id;
  late String title;
  late List<ChecklistElement> elems;

  factory ChecklistManager() => _manager;

  ChecklistManager._internal();

  void init(int id) {
    this.id = id;
    title = NotesList().getNoteWithID(id).title;
    elems = (NotesList().getNoteWithID(id) as Checklist).chContent;
  }

  void setTitle(String newTitle) {
    title = newTitle;
    updateChecklist();
  }

  void addElement() {
    elems.add(ChecklistElement());
    updateChecklist();
  }

  void removeElement(int idx) {
    elems.removeAt(idx);
    updateChecklist();
    notifyListeners();
  }

  void modifyElement(int idx, ChecklistElement newElem) {
    elems.removeAt(idx);
    elems.insert(idx, newElem);
    updateChecklist();
  }

  void updateChecklist() {
    NotesList().modifyNote(Checklist(id,
        title: title,
        chContent: elems,
        pinned: NotesList().getNoteWithID(id).pinned));
  }
}
