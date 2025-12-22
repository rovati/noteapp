import 'note.dart';

class Plaintext extends Note {
  String content;

  Plaintext(id, {title = '', this.content = '', pinned = false})
      : super(id, title: title, pinned: pinned);

  Plaintext.fromJSON(Map<String, dynamic> json)
      : content = json['content'],
        super(json['id'] as int, title: json['title'], pinned: json['pinned']);

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'plain': true,
        'title': title,
        'content': content,
        'pinned': pinned
      };

  @override
  String toFormatted() => '# $title\n\n$content';

  Plaintext modifyContent(String newContent) {
    return Plaintext(id, title: title, content: newContent);
  }

  Plaintext modifyTitle(String newTitle) {
    return Plaintext(id, title: newTitle, content: content);
  }

  bool isChecklist() => false;
}
