import 'dart:convert';
import 'dart:io';

import 'package:note_app/model/Note.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Future<List<Note>> getNotes() async {
    List<Note> notes = [];
    final path = await _localPath;
    await for (var entity in Directory(path).list()) {
      notes.add(Note.fromJSON(jsonDecode((entity as File).readAsStringSync())));
    }
    return notes;
  }

  static void writeNote(Note note) async {
    getPathForNote(note.id.toString())
        .then((file) => deleteThenWrite(file, note.toJSON().toString()));
  }

  /* Helpers */

  static Future<File> getPathForNote(String id) async {
    final path = await _localPath;
    return File('$path/$id.json');
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static void deleteThenWrite(File file, String s) {
    file.exists().then((b) => {
          if (b)
            {
              file.delete().then((f) => {(f as File).writeAsString(s)})
            }
          else
            {file.writeAsString(s)}
        });
  }
}
