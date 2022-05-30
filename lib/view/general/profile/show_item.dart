import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smallnotes/core/utils/logger.dart';
import 'package:smallnotes/view/constant/app_color.dart';
import 'package:smallnotes/view/constant/app_route.dart';
import 'package:smallnotes/view/widgets/utils.dart';

import '../../../core/provider/notes_cubit.dart';
import '../../constant/app_size.dart';
import '../../widgets/widgets.dart';

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
  final bool? isPage;
  final String? id;
  final String? getTitleNote;
  final String? getTextNote;
  final String? getDateCreate;
  final int? getBackgroundColor;
  final int? getTextColor;
  @override
  State<ShowItem> createState() => _ShowItemState();
}

class _ShowItemState extends NoteState<ShowItem> {
  ScrollController scrollController = ScrollController();
  final GlobalKey key = GlobalKey();
  Color iconColor = AppColors.black;
  double fontSize = 15;
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).selectNote();
    BlocProvider.of<NotesCubit>(context).selectFavoriteNote();
    super.initState();
  }

  void addToFavorites() async {
    final productProvider = BlocProvider.of<NotesCubit>(context);
    setState(() => iconColor = AppColors.red);

    await productProvider.insertFavoriteToDatabase(
      id: widget.id!,
      titleNote: widget.getTitleNote!,
      textNote: widget.getTextNote!,
      dateCreate: widget.getDateCreate!,
      backgroundColor: widget.getBackgroundColor!,
      textColor: widget.getTextColor!,
    );
  }

  takeScreenshot(context) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      final directory = (await getExternalStorageDirectory())!.path;

      Uint8List pngint8 = byteData.buffer.asUint8List();
      ImageGallerySaver.saveImage(Uint8List.fromList(pngint8),
          quality: 90, name: '$directory/screenshot-${DateTime.now()}');
      final msg = note.fmt(context, 'save.image');
      await ViewUtils.showSnack(context, msg: msg, color: AppColors.green);
    } else {
      final msg = note.fmt(context, 'error.unknown');
      await ViewUtils.showSnack(context, msg: msg, color: AppColors.red);
    }
  }

  onShareWithResult() async {
    final box = context.findRenderObject() as RenderBox?;
    ShareResult result;

    result = await Share.shareWithResult(
      widget.getTextNote!,
      subject: widget.getTitleNote,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
    Log.d(result.status.name);
  }

  removeItemFromDB(context) async {
    final productProvider = BlocProvider.of<NotesCubit>(context);
    await productProvider.deleteFavoriteNoteById(widget.id);
    await productProvider.deleteNoteById(widget.id);
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => AppRoute.profilePG),
        (route) => false);
  }

  removeItem() => showDialog(
        context: context,
        builder: (_) => ViewUtils.generateDialog(
          context,
          title: note.fmt(context, 'dialog.title'),
          cancelTitle: note.fmt(context, 'dialog.close'),
          actTitle: note.fmt(context, 'dialog.check'),
          onAct: () => removeItemFromDB(context),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RepaintBoundary(
        key: key,
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: size(context).width * .75,
                    height: 50,
                    decoration: ViewUtils.catalogForItemCard(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite, color: iconColor),
                          onPressed: widget.isPage! ? addToFavorites : null,
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
                  TextButton(
                    onPressed: () async {
                      await showMenu(
                        context: context,
                        position: const RelativeRect.fromLTRB(
                            300.0, 80.0, 0.0, 600.0),
                        items: [
                          PopupMenuItem(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                PopupMenuItem(
                                  child: const Text("16"),
                                  onTap: () {
                                    setState(() {
                                      fontSize = 16;
                                    });
                                  },
                                ),
                                PopupMenuItem(
                                  child: const Text("18"),
                                  onTap: () {
                                    setState(() {
                                      fontSize = 18;
                                    });
                                  },
                                ),
                                PopupMenuItem(
                                  child: const Text("20"),
                                  onTap: () {
                                    setState(() {
                                      fontSize = 20;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    child: const Text('Mətnin\nölçüsü'),
                  )
                ]),
                const SizedBox(height: 10),
                Container(
                  height: size(context).height - 60,
                  width: size(context).width,
                  padding: const EdgeInsets.all(5),
                  decoration:
                      ViewUtils.smallDecoration(color: AppColors.itemCardColor),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.getTitleNote!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w500)),
                        Text(widget.getTextNote!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 200,
                            style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
