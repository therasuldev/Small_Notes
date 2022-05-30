import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

import '../../../core/provider/notes_cubit.dart';
import '../../constant/app_color.dart';
import '../profile/show_item.dart';

class FavoritePG extends NoteStatefulWidget {
  FavoritePG({Key? key}) : super(key: key);

  @override
  State<FavoritePG> createState() => _FavoritePGState();
}

class _FavoritePGState extends NoteState<FavoritePG> {
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).selectNote();
    BlocProvider.of<NotesCubit>(context).selectFavoriteNote();
    super.initState();
  }

  deleteFromFavorites({
    required NotesCubit productProvider,
    required dynamic pickId,
    required int index,
  }) {
    return showDialog(
      context: context,
      builder: (_) {
        return ViewUtils.generateDialog(
          context,
          title: note.fmt(context, 'deleted.favorite'),
          cancelTitle: note.fmt(context, 'dialog.close'),
          actTitle: note.fmt(context, 'dialog.check'),
          onAct: () {
            productProvider.deleteFavoriteNoteById(pickId);
            productProvider.favoriteItem.removeAt(index);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          final productProvider = BlocProvider.of<NotesCubit>(context);
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return productProvider.favoriteItem.isEmpty
              ? Align(
                  heightFactor: 45,
                  child: Text(note.fmt(context, 'data.isEmpty')))
              : ListView.builder(
                  itemExtent: 200,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: productProvider.favoriteItem.length,
                  itemBuilder: (BuildContext context, int index) {
                    var helper = productProvider.favoriteItem[index];
                    return _getFavoriteItems(helper, productProvider, index);
                  },
                );
        },
      ),
    );
  }

  Widget _getFavoriteItems(
    FavoriteModel helper,
    NotesCubit productProvider,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => ShowItem(
                      isPage: false,
                      id: helper.id,
                      getTitleNote: helper.titleNote,
                      getTextNote: helper.textNote,
                      getDateCreate: helper.dateCreate,
                      getBackgroundColor: helper.backgroundColor,
                      getTextColor: helper.textColor,
                    )),
            (route) => true);
      },
      child: Container(
        decoration: ViewUtils.favoriteCardDecoration(helper.backgroundColor),
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite),
                  color: AppColors.red,
                  iconSize: 30,
                  onPressed: () => deleteFromFavorites(
                    productProvider: productProvider,
                    pickId: helper.id,
                    index: index,
                  ),
                ),
                Expanded(child: Container()),
                Text(helper.dateCreate,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(helper.textColor))),
              ],
            ),
            const SizedBox(height: 3),
            Flexible(
              child: Text(
                helper.titleNote,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(helper.textColor)),
                maxLines: 1,
              ),
            ),
            Flexible(
              child: Text(
                helper.textNote,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Color(helper.textColor)),
                maxLines: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
