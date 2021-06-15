class Note {
  final int id;
  String title;
  String content;

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

  void modifyContent(String newContent) {
    this.content = newContent;
  }

  void modifyTitle(String newTitle) {
    this.title = newTitle;
  }
}
