import 'package:note_app/model/checklist/ChecklistElement.dart';

import '../Note.dart';

class Checklist extends Note {
  List<ChecklistElement> chContent;

  Checklist(id, {title = '', chContent = const []})
      : chContent = contentConstructor(chContent),
        super(id, title: title);

  Checklist.fromJSON(Map<String, dynamic> json)
      : chContent = getContent(json['content']),
        super(json['id'] as int, title: json['title']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['plain'] = false;
    json['title'] = title;
    json['content'] = chContent.map((e) => e.toJson()).toList();
    json['pinned'] = pinned;
    return json;
  }

  static List<ChecklistElement> getContent(List<dynamic> jsonList) =>
      jsonList.map((e) => ChecklistElement.fromJson(e)).toList();

  static List<ChecklistElement> contentConstructor(List<dynamic> elems) {
    if (elems.isEmpty) {
      return [ChecklistElement()];
    } else {
      return elems as List<ChecklistElement>;
    }
  }

  ChecklistElement elementAt(int idx) {
    return chContent[idx];
  }

  void addElement() {
    chContent.add(ChecklistElement());
  }

  void addElementAfter(int idx) {
    chContent.insert(idx + 1, ChecklistElement());
  }

  void deleteElementAt(int idx) {
    chContent.removeAt(idx);
  }

  int length() {
    return chContent.length;
  }
}
