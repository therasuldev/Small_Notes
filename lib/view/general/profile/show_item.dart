import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smallnotes/core/model/note_model.dart';
import 'package:smallnotes/core/provider/favorite_bloc/favorite_bloc.dart';
import 'package:smallnotes/core/provider/note_bloc/note_bloc.dart';
import 'package:smallnotes/core/service/favorite_service.dart';
import 'package:smallnotes/core/service/note_service.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/widgets/utils.dart';

class ShowItem extends NoteStatefulWidget {
  ShowItem({
    this.isPage,
    this.id,
    this.getTitleNote,
    this.getTextNote,
    this.getDateCreate,
    this.getBackgroundColor,
    this.getTextColor,
    Key? key,
  }) : super(key: key);
  final dynamic id;
  final bool? isPage;
  final String? getTitleNote;
  final String? getTextNote;
  final String? getDateCreate;
  final int? getBackgroundColor;
  final int? getTextColor;

  @override
  State<ShowItem> createState() => _ShowItemState();
}

class _ShowItemState extends NoteState<ShowItem> {
  final scrollController = ScrollController();
  final titleController = TextEditingController();
  final textController = TextEditingController();
  final GlobalKey key = GlobalKey();

  Color iconColor = AppColors.darkYellow;
  bool editItem = false;
  bool _isFavorite = false;
  bool _onTap = false;
  double fontSize = 15;
  dynamic _value;
  String newTitleNote = '';
  String newTextNote = '';

  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(GetNoteEvent());
    BlocProvider.of<FavoriteBloc>(context).add(GetFavoritesEvent());
    isFavorite();
    super.initState();
  }

  void addToFavorite() async {
    final model = NoteModel(
      titleNote: widget.getTitleNote!,
      textNote: widget.getTextNote!,
      dateCreate: widget.getDateCreate!,
      backgroundColor: widget.getBackgroundColor!,
      textColor: widget.getTextColor!,
    );
    setState(() => _onTap = true);
    context
        .read<FavoriteBloc>()
        .add(AddToFavoritesEvent(key: widget.id, model: model));
  }

  bool isFavorite() {
    var nList = NoteService.noteService.keys.toList();
    var fList = FavoriteService.favoriteService.keys.toList();
    for (var nNote in nList) {
      for (var fNote in fList) {
        if (nNote == fNote && fNote == widget.id) {
          setState(() => _isFavorite = true);
        }
      }
    }
    return _isFavorite;
  }

  void editNote() => setState(() => editItem = !editItem);

  void editedNote() async {
    final model = NoteModel(
      titleNote: newTitleNote == '' ? widget.getTitleNote! : newTitleNote,
      textNote: newTextNote == '' ? widget.getTextNote! : newTextNote,
      dateCreate: DateFormat('yyyy.MM.dd').format(DateTime.now()),
      backgroundColor: widget.getBackgroundColor!,
      textColor: widget.getTextColor!,
    );

    context
        .read<NotesBloc>()
        .add(UpdateNoteEvent(key: widget.id, model: model));

    _isFavorite
        ? context
            .read<FavoriteBloc>()
            .add(UpdateFavoriteEvent(key: widget.id, model: model))
        : null;
    setState(() => editItem = false);
    Navigator.pop(context);
  }

  void takeScreenshot(context) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      Uint8List pngint8 = byteData.buffer.asUint8List();
      ImageGallerySaver.saveImage(Uint8List.fromList(pngint8),
          quality: 90, name: 'screenshot-${DateTime.now()}');
      final msg = note.fmt(context, 'save.image');
      await ViewUtils.showSnack(context, msg: msg, color: AppColors.green);
    } else {
      final msg = note.fmt(context, 'error.unknown');
      await ViewUtils.showSnack(context, msg: msg, color: AppColors.red);
    }
  }

  void onShareWithResult() async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.shareWithResult(
      widget.getTextNote!,
      subject: widget.getTitleNote,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  void removeItemFromDB(context) async {
    final nProvider = BlocProvider.of<NotesBloc>(context);
    final fProvider = BlocProvider.of<FavoriteBloc>(context);

    nProvider.add(RemoveNoteEvent(key: widget.id));
    fProvider.add(RemoveFavoriteEvent(key: widget.id));
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => AppRoute.generalHome),
        (route) => false);
  }

  void removeItem() => showDialog(
        context: context,
        builder: (_) => ViewUtils.generateDialog(
          context,
          title: note.fmt(context, 'deleted.note'),
          cancelTitle: note.fmt(context, 'dialog.close'),
          actTitle: note.fmt(context, 'dialog.check'),
          onAct: () => removeItemFromDB(context),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _functionsForNote(context),
              const SizedBox(height: 10),
              editItem
                  ? _editItemContainer(context)
                  : _showItemContainer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _functionsForNote(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size(context).width,
          height: 50,
          decoration: ViewUtils.catalogForItemCard(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: (_onTap || _isFavorite)
                    ? Icon(Icons.star, color: iconColor)
                    : Icon(Icons.star_border, color: iconColor),
                onPressed: () => widget.isPage! ? addToFavorite() : null,
              ),
              IconButton(
                icon: editItem
                    ? Icon(Icons.check, color: AppColors.green)
                    : Icon(Icons.edit_note, color: AppColors.black),
                onPressed: () => !editItem ? editNote() : editedNote(),
              ),
              IconButton(
                icon: const Icon(Icons.screenshot_monitor),
                onPressed: () => takeScreenshot(context),
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => onShareWithResult(),
              ),
              IconButton(
                icon: Icon(Icons.delete_forever, color: AppColors.red),
                onPressed: () => removeItem(),
              ),
              _dropDownButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dropDownButton(BuildContext context) {
    return DropdownButton(
      items: [
        DropdownMenuItem(
          value: 1,
          alignment: Alignment.center,
          onTap: () => setState(() => fontSize = 18),
          child: const Text("18"),
        ),
        DropdownMenuItem(
          value: 2,
          alignment: Alignment.center,
          child: const Text("20"),
          onTap: () => setState(() => fontSize = 20),
        ),
        DropdownMenuItem(
          value: 3,
          alignment: Alignment.center,
          child: const Text("22"),
          onTap: () => setState(() => fontSize = 22),
        ),
        DropdownMenuItem(
          value: 4,
          alignment: Alignment.center,
          child: const Text("24"),
          onTap: () => setState(() => fontSize = 24),
        )
      ],
      onChanged: (value) {
        setState(() => _value = value);
      },
      hint: const Text('15'),
      value: _value,
    );
  }

  Widget _editItemContainer(BuildContext context) {
    return RepaintBoundary(
      key: key,
      child: Container(
        height: size(context).height - 60,
        width: size(context).width,
        padding: const EdgeInsets.all(5),
        decoration:
            ViewUtils.showAndEditItemCard(color: widget.getBackgroundColor),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.getTitleNote,
                scrollPadding: const EdgeInsets.all(0),
                enabled: true,
                maxLines: 2,
                decoration: ViewUtils.underlineBorderDecoration(),
                style: ViewUtils.fStyle(
                    fSize: fontSize, color: widget.getTextColor),
                onChanged: (String newTitle) => setState(() {
                  newTitleNote = newTitle;
                }),
              ),
              TextFormField(
                initialValue: widget.getTextNote,
                scrollPadding: const EdgeInsets.all(0),
                enabled: true,
                maxLines: 100,
                maxLength: 1000,
                decoration: ViewUtils.underlineBorderDecoration(),
                style: ViewUtils.fStyle(
                    fSize: fontSize, color: widget.getTextColor),
                onChanged: (String newText) => setState(() {
                  newTextNote = newText;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showItemContainer(BuildContext context) {
    return RepaintBoundary(
      key: key,
      child: Container(
        height: size(context).height - 60,
        width: size(context).width,
        padding: const EdgeInsets.all(5),
        decoration:
            ViewUtils.showAndEditItemCard(color: widget.getBackgroundColor),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.getTitleNote!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: ViewUtils.fStyle(
                    fSize: fontSize, color: widget.getTextColor),
              ),
              Text(
                widget.getTextNote!,
                overflow: TextOverflow.ellipsis,
                maxLines: 200,
                style: ViewUtils.fStyle(
                    fSize: fontSize, color: widget.getTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
