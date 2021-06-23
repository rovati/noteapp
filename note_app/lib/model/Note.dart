class Note {
  final int id;
  final String title;
  final String content;

  Note(this.id, {this.title = '', this.content = ''});

  Note.fromJSON(Map<String, dynamic> json)
      : id = json['id'] as int,
        title = json['title'],
        content = json['content'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
      };

  Note modifyContent(String newContent) {
    return Note(this.id, title: this.title, content: newContent);
  }

  Note modifyTitle(String newTitle) {
    return Note(this.id, title: newTitle, content: this.content);
  }
}
