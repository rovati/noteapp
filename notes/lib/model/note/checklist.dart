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
    var str = '# $title\n\n';
    for (var group in groups) {
      str += _formatGroup(group);
    }
    return str;
  }

  String _formatGroup(ChecklistGroup group) {
    var str = '## ${group.title}\n\n';
    for (var uncheckedElem in group.uncheckedElems) {
      str += '- [ ] ${uncheckedElem.content}\n';
    }
    for (var checkedElem in group.checkedElems) {
      str += '- [x] ${checkedElem.content}\n';
    }
    return str += '\n';
  }

  static List<ChecklistGroup> getGroupsFromJson(Map<String, dynamic> json) {
    // support for checklist structure of versions 3 and before
    if (json.keys.contains('content')) {
      List<ChecklistElement> unchecked = [];
      List<ChecklistElement> checked = [];

      var elems = json['content'];
      if (elems.isEmpty) {
        unchecked.add(ChecklistElement());
      } else {
        for (var elem in json['content']) {
          ChecklistElement e = ChecklistElement.fromJson(elem);
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
      if (groups.isEmpty) {
        return [ChecklistGroup()];
      } else {
        List<ChecklistGroup> parsedGroups = [];
        for (var g in groups) {
          parsedGroups.add(ChecklistGroup.fromJSON(g));
        }
        return parsedGroups;
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
