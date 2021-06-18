import 'dart:convert';
import 'dart:io';

import 'package:note_app/model/Note.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static String dir = 'notes';

  static Future<List<Note>> getNotes() async {
    await createDir();
    List<Note> notes = [];
    final path = await _localPath;
    final children = await filterFiles(Directory(path));
    for (var i = 0; i < children.length; i++) {
      notes.add(Note.fromJSON(jsonDecode(children[i].readAsStringSync())));
    }
    return notes;
  }

  static void writeNote(Note note) async {
    await createDir();
    getPathForNote(note.id.toString())
        .then((file) => deleteThenWrite(file, jsonEncode(note).toString()));
  }

  /* Helpers */

  static Future<File> getPathForNote(String id) async {
    final path = await _localPath;
    return File('$path/$id.json');
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path + '/' + dir;
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

  static Future<void> createDir() async {
    Directory dir = Directory(await _localPath);
    if (!dir.existsSync()) {
      await dir.create();
    }
  }

  static Future<List<File>> filterFiles(Directory dir) async {
    List<File> files = [];
    await for (var entity in dir.list()) {
      if (entity is File) {
        files.add(entity);
      }
    }
    return files;
  }
}
