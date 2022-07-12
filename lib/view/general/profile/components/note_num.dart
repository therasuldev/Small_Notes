import 'package:flutter/material.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

import '../../../../constant/app_color.dart';

class AllNoteNum extends NoteStatelessWidget {
  AllNoteNum({Key? key, required this.numN}) : super(key: key);
  final int numN;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 66,
      decoration: ViewUtils.noteNumCard(),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.notes, color: AppColors.black),
          Text('$numN', style: TextStyle(color: AppColors.black))
        ],
      ),
    );
  }
}
