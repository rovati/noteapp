import 'dart:async';

import 'package:flutter/material.dart';

import '../model/note/notifier/checklist_list.dart';
import '../theme/app_theme.dart';
import '../theme/themes.dart';
import '../widget/dismissible_checklist.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  final TextEditingController _titleController = new TextEditingController();
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    _titleController.text = ChecklistManager().title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AppTheme().theme.background,
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme().theme.semiTransparentBG,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          readOnly: ChecklistManager().id == -1,
                          onChanged: _onTitleModified,
                          maxLines: null,
                          maxLength: 50,
                          textInputAction: TextInputAction.done,
                          controller: _titleController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24),
                          decoration: const InputDecoration(
                            hintText: 'Note title',
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: DismissibleChecklist(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTitleModified(String ignore) {
    if (_updateTimer != null) {
      _updateTimer!.cancel();
    }
    _updateTimer =
        Timer(const Duration(milliseconds: 200), _titleUpdateCallback);
  }

  void _titleUpdateCallback() {
    ChecklistManager().setTitle(_titleController.text);
  }
}
