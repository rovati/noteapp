class ChecklistElement {
  bool isChecked;
  String content;

  ChecklistElement({this.isChecked = false, this.content = ''});

  ChecklistElement.fromJson(Map<String, dynamic> json)
      : isChecked = json['isChecked'],
        content = json['content'];

  Map<String, dynamic> toJson() => {'isChecked': isChecked, 'content': content};

  void toggleCheck() {
    isChecked = !isChecked;
  }

  void modifyContent(String newContent) {
    content = newContent;
  }
}
