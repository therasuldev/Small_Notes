import 'package:flutter/material.dart';
import 'package:smallnotes/view/constant/app_color.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

class NoteNum extends NoteStatelessWidget {
  NoteNum({Key? key, required this.noteNum}) : super(key: key);
  final int noteNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 66,
      decoration: ViewUtils.decorationForProfAppBar(AppColors.black),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.notes, color: AppColors.black),
          Text('$noteNum', style: TextStyle(color: AppColors.black))
        ],
      ),
    );
  }
}
