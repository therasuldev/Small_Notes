import 'package:flutter/material.dart';
import 'package:smallnotes/view/constant/size_constant.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

class TitleForm extends NoteStatelessWidget {
  TitleForm({
    required this.titleNoteController,
    required this.focusNode,
    Key? key,
  }) : super(key: key);

  final TextEditingController titleNoteController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: size(context).width * .9,
      decoration: ViewUtils.formDecoration(),
      padding: const EdgeInsets.only(left: 7, top: 0),
      margin: const EdgeInsets.only(top: 30),
      child: TextFormField(
        controller: titleNoteController,
        decoration: ViewUtils.nonBorderDecoration(
            hint: note.fmt(context, 'note.title')),
        toolbarOptions: ViewUtils.toolbarOptions(),
        autofocus: true,
        focusNode: focusNode,
        // onChanged: onChanged,
      ),
    );
  }
}
