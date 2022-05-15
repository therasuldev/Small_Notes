import 'package:flutter/material.dart';
import 'package:littleNotes/core/provider/notes.dart';
import 'package:littleNotes/view/constant/color_constant.dart';
import 'package:littleNotes/view/constant/size_constant.dart';
import 'package:littleNotes/view/general/profile/components/favorite_num.dart';
import 'package:littleNotes/view/general/profile/components/note_num.dart';
import 'package:littleNotes/view/widgets/fade_animations.dart';
import 'package:littleNotes/view/widgets/utils.dart';
import 'package:littleNotes/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Profile extends NoteStatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends NoteState<Profile> {
  _future() => Provider.of<NoteProvider>(context, listen: false).selectNote();
  final ScrollController _scrollController = ScrollController();
  int selectedTileIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('...'));
          }
          final productProvider = Provider.of<NoteProvider>(context);

          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            children: [
              const Padding(padding: EdgeInsets.only(top: 25)),
              Consumer<NoteProvider>(
                child: Column(
                  children: [
                    _numFavoriteAndNoteLen(productProvider: productProvider),
                    const SizedBox(height: 250),
                    Text(note.fmt(context, 'data.isEmpty')),
                  ],
                ),
                builder: (context, productProvider, child) {
                  if (productProvider.item.isEmpty) return child!;

                  return Column(
                    children: [
                      _numFavoriteAndNoteLen(productProvider: productProvider),
                      const Padding(padding: EdgeInsets.only(bottom: 15)),
                      _noteList(productProvider: productProvider),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Row _numFavoriteAndNoteLen({required NoteProvider productProvider}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NoteNum(noteNum: productProvider.item.length),
        FavoriteNum(favoriteNum: 5),
      ],
    );
  }

  Widget _noteList({required NoteProvider productProvider}) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: productProvider.item.length,
      itemBuilder: (context, index) {
        var helper = productProvider.item[index];
        return FadeAnimation(
          delay: index / 5,
          child: _dismissible(
            productProvider,
            context,
            helper,
            index,
          ),
        );
      },
      shrinkWrap: true,
    );
  }

  Widget _dismissible(
    NoteProvider productProvider,
    BuildContext context,
    NoteModel helper,
    int index,
  ) {
    return Dismissible(
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return showDialog(
            context: context,
            builder: (_) {
              return ViewUtils.generateDialog(
                context,
                title: note.fmt(context, 'dialog.title'),
                cancelTitle: note.fmt(context, 'dialog.close'),
                actTitle: note.fmt(context, 'dialog.check'),
                onAct: () {
                  productProvider.deleteNoteById(helper.id);
                  productProvider.item.removeAt(index);
                  Navigator.pop(context);
                },
              );
            },
          );
        }
        return false;
      },
      key: ValueKey(productProvider.item[index].id),
      background: Container(color: AppColors.red),
      secondaryBackground: Container(color: AppColors.green),
      child: _notesTile(helper, index),
    );
  }

  Widget _notesTile(NoteModel helper, int index) {
    final selectedTile = selectedTileIndex == index;
    final titleStyle = TextStyle(color: AppColors.black, fontSize: 18);
    final subtitleStyle = TextStyle(color: AppColors.brown, fontSize: 16);
    String textNote = '';
    String titleNote = '';

    if (helper.textNote.length > 15) {
      textNote = '${helper.textNote.substring(0, 15)}...';
    }
    if (helper.titleNote.length > 15) {
      titleNote = '${helper.titleNote.substring(0, 15)}...';
    } else {
      textNote = helper.textNote;
      titleNote = helper.titleNote;
    }

    return InkWell(
      onTap: () => setState(() => selectedTileIndex = index),
      child: Container(
        height: 70,
        width: size(context).width,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: selectedTile ? AppColors.redLight : AppColors.orangeLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 7,
              left: 7,
              child: Text(titleNote, style: titleStyle),
            ),
            Positioned(
              top: 1,
              right: 7,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
                color: selectedTile ? AppColors.white : AppColors.red,
                splashColor: AppColors.transparent,
                focusColor: AppColors.transparent,
                highlightColor: AppColors.transparent,
              ),
            ),
            Positioned(
              bottom: 7,
              left: 7,
              child: Text(textNote, style: subtitleStyle, maxLines: 1),
            ),
            Positioned(
              bottom: 7,
              right: 7,
              child: Text(helper.dateCreate, style: subtitleStyle, maxLines: 1),
            ),
          ],
        ),
      ),
    );
  }
}
