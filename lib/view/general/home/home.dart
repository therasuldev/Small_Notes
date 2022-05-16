import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smallnotes/core/provider/notes.dart';
import 'package:smallnotes/view/constant/color_constant.dart';
import 'package:smallnotes/view/general/home/components/text_form_widget.dart';
import 'package:smallnotes/view/general/home/components/title_form_widget.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

class Home extends NoteStatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends NoteState<Home> {
  final titleNoteController = TextEditingController();
  final textNoteController = TextEditingController();
  final focusNode = FocusNode();
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
    Provider.of<NoteProvider>(context, listen: false);
  }

  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (currentFocus.previousFocus()) {
      currentFocus.unfocus();
    }
  }

  void close() {
    FocusScope.of(context).requestFocus(focusNode);

    titleNoteController.clear();
    textNoteController.clear();
  }

  void check() async {
    final result = (titleNoteController.text.length >= 4 &&
        titleNoteController.text.length <= 25 &&
        textNoteController.text.length >= 4);

    if (result) {
      FocusScope.of(context).requestFocus(FocusNode());
      final productProvider = Provider.of<NoteProvider>(context, listen: false);

      await productProvider.insertDatabase(
        titleNoteController.text.trim(),
        textNoteController.text.trim(),
        DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
      );
      titleNoteController.clear();
      textNoteController.clear();

      setState(() => _textNote = '');
    } else {
      final msg = note.fmt(context, 'snack.error');
      ViewUtils.showSnack(context, msg: msg, color: AppColors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        appBar: _textNote!.isEmpty ? _initViewAppBar() : _endViewAppBar(),
        drawer: const Drawer(),
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
          onPressed: () {},
          icon: const Icon(Icons.favorite_border),
        )
      ],
    );
  }

  AppBar _endViewAppBar() {
    return AppBar(
      actions: [
        IconButton(onPressed: close, icon: const Icon(Icons.close)),
        IconButton(onPressed: check, icon: const Icon(Icons.check)),
      ],
    );
  }
}
