import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smallnotes/constant/app_color.dart';
import 'package:smallnotes/core/model/note_model.dart';
import 'package:smallnotes/core/provider/note_bloc/note_bloc.dart';
import 'package:smallnotes/view/general/components/favorite.dart';
import 'package:smallnotes/view/general/home/components/text_form_widget.dart';
import 'package:smallnotes/view/general/home/components/title_form_widget.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

import '../../../constant/animation_route/right_to_left_route.dart';
import '../../widgets/drawer_components.dart';

class Home extends NoteStatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends NoteState<Home> {
  final titleNoteController = TextEditingController();
  final textNoteController = TextEditingController();
  final focusNode = FocusNode();
  Color pickerColorBACKG = AppColors.brownLight;
  Color pickerColorTEXT = AppColors.brownLight;
  Color backgroundColor = AppColors.brown.withOpacity(.7);
  Color textColor = AppColors.black;
  String? _textNote = '';

  @override
  void dispose() {
    titleNoteController.dispose();
    textNoteController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (currentFocus.previousFocus()) currentFocus.unfocus();
  }

  void changePickerColorForBackground(Color color) => setState(() {
        pickerColorBACKG = color;
        backgroundColor = pickerColorBACKG;
      });
  void changePickerColorForText(Color color) => setState(() {
        pickerColorTEXT = color;
        textColor = pickerColorTEXT;
      });

  selectColor() {
    FocusScope.of(context).requestFocus(FocusNode());
    final selectColor = note.fmt(context, 'select.background.color');
    final changeColor = note.fmt(context, 'change.color');
    return ViewUtils.bottomSheet(
      context: context,
      selectColor: selectColor,
      changeColor: changeColor,
      pickerColor: pickerColorBACKG,
      changePickerColor: changePickerColorForBackground,
    );
  }

  selectTextColor() {
    FocusScope.of(context).requestFocus(FocusNode());
    final selectColor = note.fmt(context, 'select.text.color');
    return ViewUtils.selectTextColorSheet(
      context: context,
      textColor: selectColor,
      pickerColor: pickerColorTEXT,
      changePickerColor: changePickerColorForText,
    );
  }

  void close() {
    FocusScope.of(context).unfocus();
    titleNoteController.clear();
    textNoteController.clear();
    setState(() => _textNote = '');
  }

  void check() async {
    final result = (titleNoteController.text.length >= 4 &&
        textNoteController.text.length >= 4 &&
        textNoteController.text.length <= 1000);

    if (result) {
      FocusScope.of(context).requestFocus(FocusNode());
      final nProvider = BlocProvider.of<NotesBloc>(context);

      final model = NoteModel(
        titleNote: titleNoteController.text.trim(),
        textNote: textNoteController.text.trim(),
        dateCreate: DateFormat('yyyy.MM.dd').format(DateTime.now()),
        backgroundColor: backgroundColor.value,
        textColor: textColor.value,
      );

      nProvider.add(AddNoteEvent(key: const Uuid().v4(), model: model));

      titleNoteController.clear();
      textNoteController.clear();

      setState(() => _textNote = '');
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
      final msg = note.fmt(context, 'error.snack');
      ViewUtils.showSnack(context, msg: msg, color: AppColors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        appBar: _textNote!.isEmpty ? _firstAppBar(context) : _lastAppBar(),
        drawer: NoteDrawer(),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            TitleForm(
              titleNoteController: titleNoteController,
              focusNode: focusNode,
            ),
            TextForm(
              textNoteController: textNoteController,
              noteLength: 1000 - _textNote!.length,
              onChanged: (text) => setState(() => _textNote = text),
            )
          ],
        ),
      ),
    );
  }

  AppBar _firstAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
      title: Text(
        note.fmt(context, 'app.title'),
        style: TextStyle(color: AppColors.brown),
      ),
      actions: [
        IconButton(
          onPressed: () =>
              rTlRoute(context: context, route: FavoritePG(), back: true),
          icon: Icon(Icons.star, color: AppColors.darkYellow),
        )
      ],
    );
  }

  AppBar _lastAppBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: selectColor,
          icon: Icon(Icons.color_lens, color: backgroundColor),
        ),
        IconButton(
          onPressed: selectTextColor,
          icon: Icon(Icons.colorize_sharp, color: textColor),
        ),
        IconButton(onPressed: close, icon: const Icon(Icons.close)),
        IconButton(onPressed: check, icon: const Icon(Icons.check)),
      ],
    );
  }
}
