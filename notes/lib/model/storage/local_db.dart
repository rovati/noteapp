import 'dart:convert';
import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';

import '../../util/app_values.dart';
import '../note/checklist.dart';
import '../note/note.dart';
import '../note/plaintext.dart';
import 'notes_order.dart';
import 'parse_result.dart';

class LocalDB {
  static final LocalDB _localDB = LocalDB._internal();
  late Future<ParseResult> notes;

  factory LocalDB() {
    return _localDB;
  }

  LocalDB._internal() {
    notes = getNotes();
  }

  static Future<ParseResult> getNotes() async {
    await createDirs();
    List<Note> unorderedNotes = [];
    ParseResult res = ParseResult();
    final path = '${await _localPath}/${Values.notesDir}';
    final children = await filterFiles(Directory(path));
    for (var i = 0; i < children.length; i++) {
      final string = children[i].readAsStringSync();
      try {
        unorderedNotes.add(buildNote(jsonDecode(string)));
      } catch (e) {
        res.addUnparsed(string);
      }
    }
    res.addAllParsed(await sortByOrdering(unorderedNotes));
    return res;
  }

  static void writeNote(Note note, NotesOrder ord) async {
    await createDirs();
    getPathForNote(note.id.toString()).then((file) {
      if (note is Plaintext) {
        file.writeAsString(jsonEncode(note as Plaintext).toString());
      } else {
        file.writeAsString(jsonEncode(note as Checklist).toString());
      }
    });
    writeOrdering(ord);
  }

  static void deleteNote(int id, NotesOrder ord) async {
    getPathForNote(id.toString()).then((file) => file.delete());
    writeOrdering(ord);
  }

  static Future<bool> archiveNotes() async {
    formatAndSaveNotes();
    var notesDir = await _localPath + Values.notesDir;
    var zipDir = await _externalPath;
    final zipFile = File('$zipDir/notes.zip');

    try {
      ZipFile.createFromDirectory(
          sourceDir: Directory(notesDir),
          zipFile: zipFile,
          recurseSubDirs: true);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  /* Helpers */

  static Future<File> getPathForNote(String id) async {
    final path = await _localPath;
    return File('$path/${Values.notesDir}/$id.json');
  }

  static Future<File> getPathForOrdering() async {
    final path = await _localPath;
    return File('$path/${Values.notesOrderDir}/ordering.json');
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // NOTE this only works for android!
  static Future<String> get _externalPath async {
    final directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  static Future<void> createDirs() async {
    Directory notesDir = Directory('${await _localPath}/${Values.notesDir}');
    Directory ordDir = Directory('${await _localPath}/${Values.notesOrderDir}');
    if (!notesDir.existsSync()) {
      await notesDir.create();
    }
    if (!ordDir.existsSync()) {
      await ordDir.create();
    }
    getPathForOrdering().then((file) {
      if (!file.existsSync()) {
        file.writeAsString(NotesOrder().toString());
      }
    });
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

  static void formatAndSaveNotes() async {
    Directory tempDir = Directory('${await _localPath}/${Values.tempDir}');
    var lcPath = await _localPath;

    // clear folder
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
    await tempDir.create();

    // format each note and save as plain text file
    var idxFileName = 0;
    getNotes().then((res) {
      for (var note in res.parsed) {
        var file = File('$lcPath/${Values.tempDir}/note_$idxFileName.txt');
        file.writeAsString(note.toFormatted());
        idxFileName++;
      }
    });
  }

  static Note buildNote(Map<String, dynamic> json) {
    // for backward compatibility
    if (!json.keys.contains('plain')) {
      json['plain'] = true;
    }
    if (!json.keys.contains('pinned')) {
      json['pinned'] = false;
    }
    if (json['plain']) {
      return Plaintext.fromJSON(json);
    } else {
      return Checklist.fromJSON(json);
    }
  }

  static Future<List<Note>> sortByOrdering(List<Note> notes) async {
    final NotesOrder ord = await getPathForOrdering().then((file) {
      String dec = file.readAsStringSync();
      return NotesOrder.fromString(dec);
    });
    List<Note> orderedNotes = [];
    for (int i = 0; i < ord.length; i++) {
      final id = ord.idAt(i);
      for (var note in notes) {
        if (note.id == id) {
          orderedNotes.add(note);
        }
      }
    }
    return orderedNotes;
  }

  static void writeOrdering(NotesOrder ordering) async {
    await createDirs();
    getPathForOrdering().then((file) {
      String enc = ordering.toString();
      file.writeAsString(enc);
    });
  }

  static Future<List<String>> recoverNotes() async {
    await createDirs();
    List<String> unparsedNotes = [];
    final path = '${await _localPath}/${Values.notesDir}';
    final children = await filterFiles(Directory(path));
    for (var i = 0; i < children.length; i++) {
      unparsedNotes.add(children[i].readAsStringSync());
    }
    return unparsedNotes;
  }
}
