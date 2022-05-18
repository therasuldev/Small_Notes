import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallnotes/core/provider/notes.dart';
import 'package:smallnotes/view/constant/color_constant.dart';
import 'package:smallnotes/view/constant/size_constant.dart';
import 'package:smallnotes/view/general/profile/components/favorite_num.dart';
import 'package:smallnotes/view/general/profile/components/note_num.dart';
import 'package:smallnotes/view/widgets/fade_animations.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

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
      backgroundColor: const Color.fromARGB(134, 232, 200, 193),
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
                    _statisticsFavLen(productProvider: productProvider),
                    const SizedBox(height: 250),
                    Text(note.fmt(context, 'data.isEmpty')),
                  ],
                ),
                builder: (context, productProvider, child) {
                  if (productProvider.item.isEmpty) return child!;

                  return Column(
                    children: [
                      _statisticsFavLen(productProvider: productProvider),
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

  Row _statisticsFavLen({required NoteProvider productProvider}) {
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
    final titleStyle = TextStyle(color: Color(helper.textColor), fontSize: 18);
    final subtitleStyle =
        TextStyle(color: Color(helper.textColor), fontSize: 16);
    final dateStyle = TextStyle(color: Color(helper.textColor), fontSize: 16);

    if (helper.titleNote.length >= 15) {
      helper.titleNote = '${helper.titleNote.substring(0, 15)}...';
    }

    return InkWell(
      onTap: () => setState(() => selectedTileIndex = index),
      canRequestFocus: false,
      enableFeedback: false,
      excludeFromSemantics: false,
      autofocus: false,
      child: Container(
        height: 70,
        width: size(context).width,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color:
              selectedTile ? AppColors.blueGrey : Color(helper.backgroundColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 7,
              left: 7,
              child: Text(helper.titleNote, style: titleStyle),
            ),
            Positioned(
              top: 7,
              right: 7,
              child: Text(helper.dateCreate, style: dateStyle, maxLines: 1),
            ),
            Positioned(
              bottom: 7,
              left: 7,
              child: Text(helper.textNote, style: subtitleStyle, maxLines: 1),
            ),
          ],
        ),
      ),
    );
  }
}
