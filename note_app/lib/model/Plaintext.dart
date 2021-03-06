import 'Note.dart';

class Plaintext extends Note {
  String content;

  Plaintext(id, {title = '', this.content = '', pinned = false})
      : super(id, title: title, pinned: pinned);

  Plaintext.fromJSON(Map<String, dynamic> json)
      : content = json['content'],
        super(json['id'] as int, title: json['title'], pinned: json['pinned']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'plain': true,
        'title': title,
        'content': content,
        'pinned': pinned
      };

  Plaintext modifyContent(String newContent) {
    return Plaintext(this.id, title: this.title, content: newContent);
  }

  Plaintext modifyTitle(String newTitle) {
    return Plaintext(this.id, title: newTitle, content: this.content);
  }

  bool isChecklist() => false;
}
