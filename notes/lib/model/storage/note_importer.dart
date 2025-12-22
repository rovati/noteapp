import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:notes/model/note/checklist.dart';
import 'package:notes/model/note/checklist_element.dart';
import 'package:notes/model/note/checklist_group.dart';
import 'package:notes/model/note/notifier/main_list.dart';
import 'package:notes/model/note/plaintext.dart';
import 'package:notes/model/storage/note_id_generator.dart';
import 'package:notes/util/app_values.dart';
import 'package:path_provider/path_provider.dart';

class NoteImporter {
  static Future<int> importFromMarkdownFiles(List<PlatformFile> files) async {
    if (files.isEmpty) {
      return Future.value(0);
    }

    return Future.wait(files
            .where((file) => file.extension == 'md')
            .where((file) => file.path != null)
            .map((file) => File(file.path!).readAsString().then(
                (content) => _createNoteFromMarkdown(file.name, content))))
        .then((results) => results.where((res) => res).length);
  }

  static Future<int> importFromZipFile(PlatformFile file) async {
    if (file.extension == 'zip' && file.path != null) {
      final zipFile = File(file.path!);
      final destinationDir = await _tempDir;
      destinationDir.createSync(recursive: true);
      try {
        return ZipFile.extractToDirectory(
                zipFile: zipFile, destinationDir: destinationDir)
            .then((res) => Future.wait(destinationDir
                .listSync()
                .whereType<File>()
                .where((file) => file.uri.pathSegments.last.endsWith('.md'))
                .map((file) => file.readAsString().then((content) =>
                    _createNoteFromMarkdown(
                        file.uri.pathSegments.last, content)))))
            .then((results) => results.where((res) => res).length)
            .then((res) {
              zipFile.deleteSync();
              destinationDir.deleteSync(recursive: true);
              return res;
            });
      } catch (e) {
        return Future.value(0);
      }
    } else {
      return Future.value(0);
    }
  }

  static bool _createNoteFromMarkdown(String filename, String md) {
    if (NotesList().notes.length < Values.maxNotes) {
      String title = md.startsWith('# ')
          ? md.substring(0, md.indexOf('\n')).replaceAll('# ', '')
          : filename.substring(0, filename.lastIndexOf('.'));
      title = '🔁 $title';
      String body = md.substring(md.indexOf('\n')).trim();

      if (md.contains('## ') &&
          (md.contains('- [ ]') || md.contains('- [x]'))) {
        var unparsedGroups = body
            .split('## ')
            .map((elem) => elem.trim())
            .where((elem) => elem.isNotEmpty);
        List<ChecklistGroup> groups = [];
        for (var unparsedGroup in unparsedGroups) {
          var groupName = unparsedGroup.startsWith('- [')
              ? ''
              : unparsedGroup.substring(0, md.indexOf('\n'));
          var unparsedElems = unparsedGroup
              .split('\n')
              .map((elem) => elem.trim())
              .where((elem) => elem.isNotEmpty);
          var group = ChecklistGroup(title: groupName);

          for (var unparsedElem in unparsedElems) {
            if (unparsedElem.startsWith('- [ ] ')) {
              group.insertElement(ChecklistElement(
                  isChecked: false,
                  content: unparsedElem
                      .replaceAll('- [ ] ', '')
                      .replaceAll('\n', ' ')));
            } else if (unparsedElem.startsWith('- [x] ')) {
              group.insertElement(ChecklistElement(
                  isChecked: true,
                  content: unparsedElem
                      .replaceAll('- [x] ', '')
                      .replaceAll('\n', ' ')));
            }
          }

          groups.add(group);
        }
        IDProvider.getNextId().then((id) =>
            NotesList().addNote(Checklist(id, title: title, groups: groups)));
      } else {
        IDProvider.getNextId().then((id) =>
            NotesList().addNote(Plaintext(id, title: title, content: body)));
      }

      return true;
    } else {
      return false;
    }
  }

  static Future<Directory> get _tempDir async {
    var appDir = await getApplicationDocumentsDirectory();
    return Directory('${appDir.path}/${Values.tempDir}/${Values.importDir}');
  }
}
