import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/provider/notes_cubit.dart';
import 'package:smallnotes/view/constant/app_color.dart';
import 'package:smallnotes/view/constant/app_size.dart';
import 'package:smallnotes/view/general/profile/components/favorite_num.dart';
import 'package:smallnotes/view/general/profile/components/note_num.dart';
import 'package:smallnotes/view/general/profile/show_item.dart';
import 'package:smallnotes/view/widgets/fade_animations.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

class Profile extends NoteStatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends NoteState<Profile> {
  final ScrollController _scrollController = ScrollController();
  int selectedTileIndex = 0;
  Color setIconColor = AppColors.black;
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).selectNote();
    BlocProvider.of<NotesCubit>(context).selectFavoriteNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownLight,
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          final productProvider = BlocProvider.of<NotesCubit>(context);
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            children: [
              const Padding(padding: EdgeInsets.only(top: 25)),
              Column(
                children: [
                  _statisticsFavLen(productProvider: productProvider),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  productProvider.item.isEmpty
                      ? Align(
                          heightFactor: 30,
                          child: Text(note.fmt(context, 'data.isEmpty')))
                      : _noteList(productProvider: productProvider),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Row _statisticsFavLen({
    required NotesCubit productProvider,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NoteNum(noteNum: productProvider.item.length),
        FavoriteNum(favoriteNum: productProvider.favoriteItem.length),
      ],
    );
  }

  Widget _noteList({required NotesCubit productProvider}) {
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
    NotesCubit productProvider,
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
    final dateStyle = TextStyle(
        color: Color(helper.textColor),
        fontSize: 16,
        fontWeight: FontWeight.bold);

    return InkWell(
      onTap: () {
        setState(
          () {
            selectedTileIndex = index;
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (_) => ShowItem(
                          isPage: true,
                          id: helper.id,
                          getTitleNote: helper.titleNote,
                          getTextNote: helper.textNote,
                          getDateCreate: helper.dateCreate,
                          getBackgroundColor: helper.backgroundColor,
                          getTextColor: helper.textColor,
                        )),
                (route) => true);
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: ViewUtils.smallDecoration(
          color:
              selectedTile ? AppColors.blueGrey : Color(helper.backgroundColor),
          radius: const Radius.circular(10),
        ),
        height: 70,
        width: size(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: size(context).width * .7,
                    height: 30,
                    color: AppColors.transparent,
                    child: Text(
                      helper.titleNote,
                      style: titleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text(helper.dateCreate, style: dateStyle, maxLines: 1),
              ],
            ),
            Text(
              helper.textNote,
              style: subtitleStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
