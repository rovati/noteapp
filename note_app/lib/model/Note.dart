abstract class Note {
  final int id;
  String title;
  bool pinned;

  Note(this.id, {this.title = '', this.pinned = false});

  Map<String, dynamic> toJson();
}
