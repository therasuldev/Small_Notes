import 'package:flutter/material.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

import '../../../../constant/app_size.dart';

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
    final String title = note.fmt(context, 'note.title');
    return Container(
      height: 50,
      width: size(context).width * .9,
      decoration: ViewUtils.textAndTitleCard(),
      padding: const EdgeInsets.only(left: 7, top: 0),
      margin: const EdgeInsets.only(top: 30),
      child: TextFormField(
        controller: titleNoteController,
        decoration: ViewUtils.nonBorderDecoration(hint: title),
        autofocus: true,
        focusNode: focusNode,
      ),
    );
  }
}
