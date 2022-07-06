import 'package:flutter/material.dart';
import 'package:smallnotes/view/constant/app_color.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

class NoteNum extends NoteStatelessWidget {
  NoteNum({Key? key, required this.numN}) : super(key: key);
  final int numN;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 66,
      decoration: ViewUtils.kDecor(
          color: AppColors.white.value,
          borderColor: AppColors.black.value,
          borderWidth: 2,
          tL: 10,
          tR: 10),
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
