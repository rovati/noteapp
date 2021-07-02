abstract class Note {
  final int id;
  String title;

  Note(this.id, {this.title = ''});

  Map<String, dynamic> toJson();
}
