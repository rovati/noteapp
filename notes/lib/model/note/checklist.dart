import 'checklist_element.dart';
import 'checklist_group.dart';
import 'note.dart';

class Checklist extends Note {
  List<ChecklistGroup> groups;

  Checklist(id, {title = '', groups = const [], pinned = false})
      : groups = groupsExtractor(groups),
        super(id, title: title, pinned: pinned);

  Checklist.fromJSON(Map<String, dynamic> json)
      : groups = getGroupsFromJson(json),
        super(json['id'] as int, title: json['title'], pinned: json['pinned']);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['plain'] = false;
    json['title'] = title;
    json['groups'] = groups.map((e) => e.toJson()).toList();
    json['pinned'] = pinned;
    return json;
  }

  @override
  String toFormatted() {
    var str = 'Title: $title\n\n';
    for (var group in groups) {
      str += '$group\n';
    }
    return str;
  }

  static List<ChecklistGroup> getGroupsFromJson(Map<String, dynamic> json) {
    // support for checklist structure of versions 3 and before
    if (!json.keys.contains('content')) {
      var unchecked = [];
      var checked = [];

      var elems = json['content'];
      if (elems.isEmpty()) {
        unchecked.add(ChecklistElement());
      } else {
        for (var elem in json['content']) {
          ChecklistElement e = elem as ChecklistElement;
          if (e.isChecked) {
            checked.add(e);
          } else {
            unchecked.add(e);
          }
        }
      }

      return [ChecklistGroup(checkedElems: checked, uncheckedElems: unchecked)];
    } else {
      var groups = json['groups'];
      if (groups.isEmpty()) {
        return [ChecklistGroup()];
      } else {
        return groups as List<ChecklistGroup>;
      }
    }
  }

  static List<ChecklistGroup> groupsExtractor(List<dynamic> elems) =>
      elems.isEmpty ? [ChecklistGroup()] : elems as List<ChecklistGroup>;

  void addGroup() {
    groups.add(ChecklistGroup());
  }

  void removeGroupAt(int idx) {
    groups.removeAt(idx);
  }

  int length() {
    return groups.length;
  }
}
