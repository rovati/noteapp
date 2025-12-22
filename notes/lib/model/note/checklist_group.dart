import 'checklist_element.dart';

class ChecklistGroup {
  String title;
  List<ChecklistElement> uncheckedElems;
  List<ChecklistElement> checkedElems;

  ChecklistGroup(
      {this.title = '', uncheckedElems = const [], checkedElems = const []})
      : uncheckedElems = extractContent(uncheckedElems),
        checkedElems = extractContent(checkedElems);

  ChecklistGroup.fromJSON(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        uncheckedElems = unfoldJsonList(json['unchecked']),
        checkedElems = unfoldJsonList(json['checked']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['title'] = title;
    json['unchecked'] = uncheckedElems.map((e) => e.toJson()).toList();
    json['checked'] = checkedElems.map((e) => e.toJson()).toList();
    return json;
  }

  @override
  String toString() {
    var str = 'Group: $title\n';
    for (var elem in uncheckedElems) {
      str += '[ ] ${elem.content}\n';
    }
    for (var elem in checkedElems) {
      str += '[X] ${elem.content}\n';
    }
    return str;
  }

  static List<ChecklistElement> unfoldJsonList(List<dynamic> jsonList) =>
      jsonList.map((e) => ChecklistElement.fromJson(e)).toList();

  static List<ChecklistElement> extractContent(List<dynamic> elems) =>
      elems.isEmpty ? [] : elems as List<ChecklistElement>;

  ChecklistElement uncheckedElementAt(int idx) => uncheckedElems[idx];
  ChecklistElement checkedElementAt(int idx) => checkedElems[idx];

  void addElement() {
    uncheckedElems.add(ChecklistElement());
  }

  void insertElement(ChecklistElement elem) {
    if (elem.isChecked) {
      checkedElems.add(elem);
    } else {
      uncheckedElems.add(elem);
    }
  }

  void removeUncheckedElementAt(int idx) {
    uncheckedElems.removeAt(idx);
  }

  void removeCheckedElementAt(int idx) {
    checkedElems.removeAt(idx);
  }

  void updateElementAt(int idx, ChecklistElement newElement) {
    uncheckedElems.removeAt(idx);
    uncheckedElems.insert(idx, newElement);
  }

  int get uncheckedLength => uncheckedElems.length;
  int get checkedLength => checkedElems.length;
}
