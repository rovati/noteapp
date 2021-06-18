class Note {
  final int id;
  final String title;
  final String content;

  Note(this.id, title, {this.content = ''})
      : this.title = title + ' ' + id.toString();

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
    return Note(this.id, this.title, content: newContent);
  }

  Note modifyTitle(String newTitle) {
    return Note(this.id, newTitle, content: this.content);
  }
}
