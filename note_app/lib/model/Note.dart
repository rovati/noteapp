class Note {
  final int id;
  final String title;
  final String content;

  Note(this.id, this.title, {this.content = ''});

  Note.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'];

  Map<String, dynamic> toJSON() => {
        'id': id,
        'title': title,
        'content': content,
      };

  Note modifyContent(String newContent) {
    return Note(this.id, this.title, content: newContent);
  }

  Note modifyTitle(String newTitle) {
    return Note(this.id, newTitle, content: this.content);
  }
}
