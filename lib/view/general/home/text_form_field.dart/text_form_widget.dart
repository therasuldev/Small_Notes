// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/widgets/utils.dart';

class TextForm extends NoteStatelessWidget {
  TextForm({
    required this.textNoteController,
    required this.noteLength,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final TextEditingController textNoteController;
  void Function(String)? onChanged;
  final int noteLength;

  @override
  Widget build(BuildContext context) {
    final hintText = note.fmt(context, 'note.text');
    return Container(
      height: size(context).height * .65,
      width: size(context).width * .9,
      decoration: ViewUtils.textAndTitleCard(),
      padding: const EdgeInsets.only(left: 7, top: 0),
      margin: const EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          TextFormField(
            controller: textNoteController,
            decoration: ViewUtils.nonBorderDecoration(hint: hintText),
            maxLines: 100,
            autofocus: true,
            onChanged: onChanged,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 20,
              width: 45,
              alignment: Alignment.center,
              decoration: ViewUtils.defaultCard(),
              child:
                  Text('$noteLength', style: TextStyle(color: AppColors.white)),
            ),
          )
        ],
      ),
    );
  }
}
