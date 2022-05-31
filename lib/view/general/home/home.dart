import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smallnotes/core/provider/notes_cubit.dart';
import 'package:smallnotes/view/constant/app_color.dart';
import 'package:smallnotes/view/constant/app_route.dart';
import 'package:smallnotes/view/general/home/components/text_form_widget.dart';
import 'package:smallnotes/view/general/home/components/title_form_widget.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

import 'drawer/drawer_components.dart';

class Home extends NoteStatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends NoteState<Home> {
  final titleNoteController = TextEditingController();
  final textNoteController = TextEditingController();
  final route = AppRoute();
  final focusNode = FocusNode();
  Color pickerColor = AppColors.brownLight;
  Color backgroundColor = AppColors.white;
  Color textColor = AppColors.black;
  String? _textNote = '';

  @override
  void dispose() {
    titleNoteController.dispose();
    textNoteController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesCubit>(context);
  }

  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (currentFocus.previousFocus()) currentFocus.unfocus();
  }

  void changePickerColor(Color color) => setState(() {
        pickerColor = color;
        backgroundColor = pickerColor;
      });

  void changeToBlack() => setState(() => textColor = AppColors.black);

  void changeToWhite() => setState(() => textColor = AppColors.white);

  selectColor() {
    FocusScope.of(context).requestFocus(FocusNode());
    final selectColor = note.fmt(context, 'select.background.color');
    final changeColor = note.fmt(context, 'change.color');
    return ViewUtils.bottomSheet(
      context: context,
      selectColor: selectColor,
      changeColor: changeColor,
      pickerColor: pickerColor,
      changePickerColor: changePickerColor,
    );
  }

  selectTextColor() {
    FocusScope.of(context).requestFocus(FocusNode());
    return ViewUtils.showMENU(
      context: context,
      whiteColor: changeToWhite,
      blackColor: changeToBlack,
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
      final productProvider = BlocProvider.of<NotesCubit>(context);

      await productProvider.insertDatabase(
        id: const Uuid().v1(),
        titleNote: titleNoteController.text.trim(),
        textNote: textNoteController.text.trim(),
        dateCreate: DateFormat('yyyy.MM.dd').format(DateTime.now()).toString(),
        backgroundColor: backgroundColor.value,
        textColor: textColor.value,
      );
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
        appBar: _textNote!.isEmpty ? _initViewAppBar() : _endViewAppBar(),
        drawer: NoteDrawer(),
        body: SingleChildScrollView(
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
        ),
      ),
    );
  }

  AppBar _initViewAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(note.fmt(context, 'app.title')),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, route.appRoutes.keys.elementAt(1));
          },
          icon: const Icon(Icons.favorite_border),
        )
      ],
    );
  }

  AppBar _endViewAppBar() {
    return AppBar(
      actions: [
        IconButton(
            onPressed: selectColor,
            icon: Icon(Icons.color_lens, color: backgroundColor)),
        IconButton(
            onPressed: selectTextColor,
            icon: Icon(Icons.colorize_sharp, color: textColor)),
        IconButton(onPressed: close, icon: const Icon(Icons.close)),
        IconButton(onPressed: check, icon: const Icon(Icons.check)),
      ],
    );
  }
}
