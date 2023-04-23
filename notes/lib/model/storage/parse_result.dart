import '../note/note.dart';

class ParseResult {
  List<Note> parsed;
  List<String> unparsed;

  ParseResult()
      : parsed = [],
        unparsed = [];

  void addParsed(Note note) {
    parsed.add(note);
  }

  void addAllParsed(List<Note> notes) {
    parsed.addAll(notes);
  }

  void addUnparsed(String s) {
    unparsed.add(s);
  }

  void addAllUnparsed(List<String> ls) {
    unparsed.addAll(ls);
  }
}
