import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:notes/model/storage/local_db.dart';
import 'package:notes/model/storage/note_importer.dart';
import 'package:notes/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  late Color _exportIconColor;
  late Color _tapColor;
  bool _isExporting = false;
  bool _isImporting = false;

  @override
  void initState() {
    super.initState();
    _exportIconColor = AppTheme().theme.secondaryColor;
    _tapColor = AppTheme().theme.toolbarIconTapColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppTheme>(
        builder: (context, appTheme, child) => Stack(
          children: [
            appTheme.theme.background,
            SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            'Export notes',
                            style: TextStyle(color: _exportIconColor),
                          ),
                        ),
                      ),
                      _tileButton(
                          appTheme, '.zip', Icons.download, _onTapExport),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            'Import notes',
                            style: TextStyle(color: _exportIconColor),
                          ),
                        ),
                      ),
                      _tileButton(appTheme, '.zip', Icons.upload,
                          () => _onTapImport('zip')),
                      _tileButton(appTheme, '.md', Icons.upload,
                          () => _onTapImport('md')),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tileButton(
          AppTheme appTheme, String text, IconData icon, Function() callback) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Material(
          color: appTheme.theme.semiTransparentBG,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: callback,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: _exportIconColor,
                    ),
                    Text(
                      text,
                      style: TextStyle(color: _exportIconColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void _onTapExport() {
    if (!_isExporting) {
      _isExporting = true;
      SnackBar snack;

      setState(() {
        _exportIconColor = _tapColor;
      });
      LocalDB.archiveNotes().then((res) {
        if (res) {
          snack = const SnackBar(
            content: Text('Notes archive saved to Downloads directory'),
          );
        } else {
          snack = const SnackBar(
            content: Text('Could not create the notes archive!'),
          );
        }
        setState(() {
          _exportIconColor = AppTheme().theme.secondaryColor;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snack);
        }
        _isExporting = false;
      });
    }
  }

  void _onTapImport(String extension) {
    if (!_isImporting) {
      _isImporting = true;
      setState(() {
        _exportIconColor = _tapColor;
      });
      SnackBar snack;

      FilePicker.platform.pickFiles(
        allowMultiple: extension != 'zip',
        type: FileType.custom,
        allowedExtensions: [extension],
      ).then((optResut) {
        if (optResut != null && optResut.files.isNotEmpty) {
          if (extension == 'zip') {
            NoteImporter.importFromZipFile(optResut.files.first)
                .then((importedNotes) {
              setState(() {
                _exportIconColor = AppTheme().theme.secondaryColor;
              });
              _isImporting = false;
              snack = SnackBar(
                  content:
                      Text('Imported $importedNotes notes from Zip files.'));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(snack);
              }
            });
          } else if (extension == 'md') {
            NoteImporter.importFromMarkdownFiles(optResut.files)
                .then((importedNotes) {
              setState(() {
                _exportIconColor = AppTheme().theme.secondaryColor;
              });
              _isImporting = false;
              snack = SnackBar(
                  content:
                      Text('Imported $importedNotes notes from Md files.'));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(snack);
              }
            });
          }
        } else {
          snack = const SnackBar(content: Text('No file selected for import.'));
          setState(() {
            _exportIconColor = AppTheme().theme.secondaryColor;
          });
          _isImporting = false;
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(snack);
          }
        }
      });
    }
  }
}
