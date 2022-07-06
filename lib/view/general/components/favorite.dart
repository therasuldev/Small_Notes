import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/provider/favorite_bloc/favorite_bloc.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

import '../../../core/provider/note_bloc/note_bloc.dart';
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
    BlocProvider.of<NotesBloc>(context).add(GetNoteEvent());
    BlocProvider.of<FavoriteBloc>(context).add(GetFavoritesEvent());
    super.initState();
  }

  deleteFromFavorites({
    required FavoriteBloc fProvider,
    required dynamic id,
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
            fProvider.add(RemoveFavoriteEvent(id: id));
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          final fProvider = BlocProvider.of<FavoriteBloc>(context);
          if (state is FavoriteSuccess) {
            // return state.favoriteItem.isEmpty
            //     ? Center(
            //         child:
            //             Lottie.asset('assets/lottie/empty.json', repeat: false))
            return ListView.builder(
              itemExtent: 200,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.keys?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                var item = state.values[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => ShowItem(
                                  isPage: false,
                                  id: state.keys[index],
                                  getTitleNote: item['titleNote'],
                                  getTextNote: item['textNote'],
                                  getDateCreate: item['dateCreate'],
                                  getBackgroundColor: item['backgroundColor'],
                                  getTextColor: item['textColor'],
                                )),
                        (route) => true);
                  },
                  child: Container(
                    decoration: ViewUtils.kDecor(
                        bR: 15,
                        tL: 15,
                        bL: 15,
                        tR: 15,
                        color: item['backgroundColor'],
                        borderColor: AppColors.black.value),
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
                                fProvider: fProvider,
                                id: state.keys[index],
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(item['dateCreate'],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(item['textColor']))),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Flexible(
                          child: Text(
                            item['titleNote'],
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(item['textColor'])),
                            maxLines: 1,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            item['textNote'],
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Color(item['textColor'])),
                            maxLines: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
