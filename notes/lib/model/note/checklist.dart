import 'checklist_element.dart';
import 'note.dart';

class Checklist extends Note {
  List<ChecklistElement> chContent;

  Checklist(id, {title = '', chContent = const [], pinned = false})
      : chContent = contentConstructor(chContent),
        super(id, title: title, pinned: pinned);

  Checklist.fromJSON(Map<String, dynamic> json)
      : chContent = getContent(json['content']),
        super(json['id'] as int, title: json['title'], pinned: json['pinned']);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['plain'] = false;
    json['title'] = title;
    json['content'] = chContent.map((e) => e.toJson()).toList();
    json['pinned'] = pinned;
    return json;
  }

  @override
  String toFormatted() {
    var string = 'Title: $title\n\n';
    for (var element in chContent) {
      if (element.isChecked) {
        string += '[X] ${element.content}\n';
      } else {
        string += '[ ] ${element.content}\n';
      }
    }
    return string;
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
