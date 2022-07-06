import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smallnotes/core/provider/favorite_bloc/favorite_bloc.dart';
import 'package:smallnotes/core/provider/note_bloc/note_bloc.dart';
import 'package:smallnotes/view/constant/app_color.dart';
import 'package:smallnotes/view/constant/app_route.dart';
import 'package:smallnotes/view/widgets/utils.dart';

import '../../constant/app_size.dart';
import '../../widgets/widgets.dart';

// ignore: must_be_immutable
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
  final String? id;
  final bool? isPage;
  String? getTitleNote;
  String? getTextNote;
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

  Color iconColor = AppColors.black;
  bool editItem = false;
  double fontSize = 15;
  dynamic _value;
  String newTitleNote = '';
  String newTextNote = '';

  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(GetNoteEvent());
    BlocProvider.of<FavoriteBloc>(context).add(GetFavoritesEvent());
    super.initState();
  }

  void addToFavorite() async {
    final values = ({
      'titleNote': widget.getTitleNote,
      'textNote': widget.getTextNote,
      'dateCreate': widget.getDateCreate,
      'backgroundColor': widget.getBackgroundColor,
      'textColor': widget.getTextColor,
    });
    context.read<FavoriteBloc>().add(AddToFavoritesEvent(widget.id, values));
  }

  void editNote() => setState(() => editItem = !editItem);
  void editedNote() async {
    final values = ({
      'textNote': newTextNote == '' ? widget.getTextNote : newTextNote,
      'titleNote': newTitleNote == '' ? widget.getTitleNote : newTitleNote,
      'dateCreate': DateFormat('yyyy.MM.dd').format(DateTime.now()),
      'backgroundColor': widget.getBackgroundColor!,
      'textColor': widget.getTextColor!,
    });

    context
        .read<NotesBloc>()
        .add(UpdateNoteEvent(id: widget.id!, values: values));
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
    final noteProvider = BlocProvider.of<NotesBloc>(context);
    final favoriteProvider = BlocProvider.of<FavoriteBloc>(context);

    noteProvider.add(RemoveNoteEvent(id: widget.id));
    favoriteProvider.add(RemoveFavoriteEvent(id: widget.id));
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
              Row(
                children: [
                  Container(
                    width: size(context).width * .75,
                    height: 50,
                    decoration: ViewUtils.catalogForItemCard(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite, color: iconColor),
                          onPressed: widget.isPage! ? addToFavorite : null,
                        ),
                        IconButton(
                          icon: editItem
                              ? Icon(Icons.check, color: AppColors.green)
                              : Icon(Icons.edit, color: AppColors.black),
                          onPressed: () {
                            !editItem ? editNote() : editedNote();
                          },
                        ),
                        IconButton(
                            onPressed: () => takeScreenshot(context),
                            icon: const Icon(Icons.screenshot_sharp)),
                        IconButton(
                            onPressed: () => onShareWithResult(),
                            icon: const Icon(Icons.share)),
                        IconButton(
                            onPressed: () => removeItem(),
                            icon: Icon(Icons.delete, color: AppColors.red)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  DropdownButton(
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
                    hint: Text(note.fmt(context, 'select.font.size')),
                    value: _value,
                  ),
                ],
              ),
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

  Widget _editItemContainer(BuildContext context) {
    return RepaintBoundary(
      key: key,
      child: Container(
        height: size(context).height - 60,
        width: size(context).width,
        padding: const EdgeInsets.all(5),
        decoration: ViewUtils.kDecor(color: widget.getBackgroundColor!),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.getTitleNote,
                scrollPadding: const EdgeInsets.all(0),
                enabled: true,
                maxLines: 2,
                decoration: ViewUtils.nonBorderDecoration(),
                style: ViewUtils.fStyle(
                    fSize: fontSize, color: widget.getTextColor!),
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
                decoration: ViewUtils.nonBorderDecoration(),
                style: ViewUtils.fStyle(
                    fSize: fontSize, color: widget.getTextColor!),
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
        decoration: ViewUtils.kDecor(color: widget.getBackgroundColor!),
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
