import 'package:flutter/material.dart';

import '../checklist.dart';
import '../checklist_element.dart';
import '../checklist_group.dart';
import 'main_list.dart';

class ChecklistManager extends ChangeNotifier {
  static final ChecklistManager _manager = ChecklistManager._internal();
  late Checklist note;

  factory ChecklistManager() => _manager;

  ChecklistManager._internal();

  void init(int id) {
    note = NotesList().getNoteWithID(id) as Checklist;
  }

  void setTitle(String newTitle) {
    note.title = newTitle;
    // notify main page of the title change
    NotesList().modifyNote(note);
  }

  void addGroup() {
    note.groups.add(ChecklistGroup());
    NotesList().modifyNote(note);
  }

  ChecklistGroup groupAt(int idx) => note.groups[idx];

  void removeGroup(int idx) {
    note.groups.removeAt(idx);
    NotesList().modifyNote(note);
  }

  void addElementToGroup(int idx) {
    note.groups[idx].addElement();
    NotesList().modifyNote(note);
  }

  void removeCheckedElementFromGroup(int groupIdx, int elementIdx) {
    note.groups[groupIdx].removeCheckedElementAt(elementIdx);
    NotesList().modifyNote(note);
    notifyListeners();
  }

  void removeUncheckedElementFromGroup(int groupIdx, int elementIdx) {
    note.groups[groupIdx].removeUncheckedElementAt(elementIdx);
    NotesList().modifyNote(note);
    notifyListeners();
  }

  // TODO why isnt it saved to local db?
  void modifyElementOfGroup(
      int groupIdx, int elementIdx, ChecklistElement newElem) {
    note.groups[groupIdx].updateElementAt(elementIdx, newElem);
    NotesList().modifyNote(note);
  }

  int groupsCount() => note.groups.length;

  ChecklistElement elem(groupIdx, elementIdx, checked) => checked
      ? note.groups[groupIdx].checkedElementAt(elementIdx)
      : note.groups[groupIdx].uncheckedElementAt(elementIdx);
}
