import 'package:flutter/material.dart';
import 'package:note_app/model/NotesList.dart';
import 'package:note_app/model/checklist/ChecklistElement.dart';

import 'Checklist.dart';

class ChecklistManager extends ChangeNotifier {
  static final ChecklistManager _manager = ChecklistManager._internal();
  late int id;
  late String title;
  late List<ChecklistElement> elems;

  factory ChecklistManager() => _manager;

  ChecklistManager._internal();

  void init(int id) {
    this.id = id;
    this.title = NotesList().getNoteWithID(id).title;
    this.elems = (NotesList().getNoteWithID(id) as Checklist).chContent;
  }

  void setTitle(String newTitle) {
    this.title = newTitle;
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
    NotesList().modifyNote(Checklist(id, title: title, chContent: elems));
  }
}
