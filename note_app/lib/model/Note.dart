class Note {
  final int id;
  String title;
  String content;

  Note(this.id, this.title, {this.content = ''});

  void modifyContent(String newContent) {
    this.content = newContent;
  }

  void modifyTitle(String newTitle) {
    this.title = newTitle;
  }
}
