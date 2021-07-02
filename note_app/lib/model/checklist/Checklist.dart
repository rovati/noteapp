import 'package:note_app/model/checklist/ChecklistElement.dart';

import '../Note.dart';

class Checklist extends Note {
  List<ChecklistElement> chContent;

  Checklist(id, {title = ''})
      : chContent = [ChecklistElement()],
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
    return json;
  }

  static List<ChecklistElement> getContent(
          List<Map<String, dynamic>> jsonList) =>
      jsonList.map((e) => ChecklistElement.fromJson(e)).toList();

  void addElement() {
    chContent.add(ChecklistElement());
  }

  void deleteElementAt(int idx) {
    chContent.removeAt(idx);
  }
}
