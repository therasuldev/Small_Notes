// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smallnotes/view/constant/app_color.dart';
import 'package:smallnotes/view/constant/app_size.dart';
import 'package:smallnotes/view/widgets/utils.dart';

import '../../../widgets/widgets.dart';

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
      decoration: ViewUtils.kDecor(
          color: AppColors.brownLight.value,
          borderColor: AppColors.black.value,
          tR: 10,
          tL: 10,
          bL: 10,
          bR: 10),
      padding: const EdgeInsets.only(left: 7, top: 0),
      margin: const EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          TextFormField(
            controller: textNoteController,
            decoration: ViewUtils.nonBorderDecoration(hint: hintText),
            toolbarOptions: ViewUtils.toolbarOptions(),
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
              decoration: ViewUtils.kDecor(
                  color: AppColors.blueGrey.value, bR: 10, tL: 10),
              child: Text(
                '$noteLength',
                style: TextStyle(color: AppColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
