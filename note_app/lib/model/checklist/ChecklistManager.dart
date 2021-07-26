import 'package:note_app/model/NotesList.dart';
import 'package:note_app/model/checklist/ChecklistElement.dart';

import 'Checklist.dart';

class ChecklistManager {
  static final ChecklistManager _manager = ChecklistManager._internal();
  late int id;
  late String title;
  late List<ChecklistElement> elems;

  factory ChecklistManager() => _manager;

  ChecklistManager._internal();

  void init(int id,
      {String title = '', List<ChecklistElement> elems = const []}) {
    this.id = id;
    this.title = title;
    this.elems = elems;
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
