import 'dart:convert';
import 'dart:io';

import 'package:note_app/model/Note.dart';
import 'package:note_app/model/Plaintext.dart';
import 'package:note_app/model/Ordering.dart';
import 'package:note_app/model/checklist/Checklist.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_archive/flutter_archive.dart';

import 'constant/app_values.dart';
import 'ParseResult.dart';

/// Database entry point. It offers a set of static functions to access the
/// local database for read and write operations.
class DatabaseHelper {
  static Future<ParseResult> getNotes() async {
    await createDirs();
    List<Note> unorderedNotes = [];
    ParseResult res = ParseResult();
    final path = await _localPath + '/' + Values.NOTES_DIR;
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

  static void writeNote(Note note, Ordering ord) async {
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

  static void deleteNote(int id, Ordering ord) async {
    getPathForNote(id.toString()).then((file) => file.delete());
    writeOrdering(ord);
  }

  static Future<bool> archiveNotes() async {
    formatAndSaveNotes();
    var notesDir = await _localPath + Values.TEMP_DIR;
    var zipDir = await _externalPath;
    final zipFile = File(zipDir + '/notes.zip');

    try {
      ZipFile.createFromDirectory(
        sourceDir: Directory(notesDir), zipFile: zipFile, recurseSubDirs: true);
      return Future.value(true);
    } catch (e) {
      print(e.toString());
      return Future.value(false);
    }
  }

  /* Helpers */

  static Future<File> getPathForNote(String id) async {
    final path = await _localPath;
    return File('$path/' + Values.NOTES_DIR + '/$id.json');
  }

  static Future<File> getPathForOrdering() async {
    final path = await _localPath;
    return File('$path/' + Values.ORDERING_DIR + '/ordering.json');
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
    Directory notesDir = Directory(await _localPath + '/' + Values.NOTES_DIR);
    Directory ordDir = Directory(await _localPath + '/' + Values.ORDERING_DIR);
    if (!notesDir.existsSync()) {
      await notesDir.create();
    }
    if (!ordDir.existsSync()) {
      await ordDir.create();
    }
    getPathForOrdering().then((file) {
      if (!file.existsSync()) {
        file.writeAsString(Ordering().toString());
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
    Directory tempDir = Directory(await _localPath + '/' + Values.TEMP_DIR);
    var lcPath = await _localPath;

    // clear folder
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
    await tempDir.create();
    
    // format each note and save as plain text file
    var idxFileName = 0;
    getNotes().then((res) {
      res.parsed.forEach((note) {
        var file = File('$lcPath/' + Values.TEMP_DIR + '/note_$idxFileName.txt');
        file.writeAsString(note.toFormatted());
        idxFileName++;
      });
    });
  }

  static Note buildNote(Map<String, dynamic> json) {
    // for back-compatibility
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
    final Ordering ord = await getPathForOrdering().then((file) {
      String dec = file.readAsStringSync();
      return Ordering.fromString(dec);
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

  static void writeOrdering(Ordering ordering) async {
    await createDirs();
    getPathForOrdering().then((file) {
      String enc = ordering.toString();
      file.writeAsString(enc);
    });
  }

  static Future<List<String>> recoverNotes() async {
    await createDirs();
    List<String> unparsedNotes = [];
    final path = await _localPath + '/' + Values.NOTES_DIR;
    final children = await filterFiles(Directory(path));
    for (var i = 0; i < children.length; i++) {
      unparsedNotes.add(children[i].readAsStringSync());
    }
    return unparsedNotes;
  }
}
