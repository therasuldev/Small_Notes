import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:smallnotes/core/provider/favorite_bloc/favorite_bloc.dart';
import 'package:smallnotes/core/service/favorite_service.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

import '../../../constant/animation_route/bottom_to_top.dart';
import '../../../constant/app_color.dart';
import '../../../core/provider/note_bloc/note_bloc.dart';
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
    required dynamic key,
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
            fProvider.add(RemoveFavoriteEvent(key: key));
            Navigator.pop(context);
          },
        );
      },
    );
  }

  final String noData = 'assets/lottie/empty.json';
  var service = FavoriteService.favoriteService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownLight,
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          final fProvider = BlocProvider.of<FavoriteBloc>(context);
          if (state is FavoriteSuccess) {
            return state.model.isEmpty
                ? Center(child: Lottie.asset(noData, repeat: false))
                : ListView.builder(
                    itemExtent: 200,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: state.model.length,
                    itemBuilder: (BuildContext context, int index) {
                      final keys = service.keys.toList();
                      var model = state.model[index];
                      return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 1,
                          duration: const Duration(milliseconds: 350),
                          child: ScaleAnimation(
                            child: GestureDetector(
                              onTap: () {
                                bTtRoute(
                                    context: context,
                                    route: ShowItem(
                                      isPage: false,
                                      id: keys[index],
                                      getTitleNote: model.titleNote,
                                      getTextNote: model.textNote,
                                      getDateCreate: model.dateCreate,
                                      getBackgroundColor: model.backgroundColor,
                                      getTextColor: model.textColor,
                                    ),
                                    back: true);
                              },
                              child: Container(
                                decoration: ViewUtils.favoriteCard(
                                  color: model.backgroundColor,
                                ),
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.star),
                                          color: AppColors.darkYellow,
                                          iconSize: 30,
                                          onPressed: () => deleteFromFavorites(
                                              fProvider: fProvider,
                                              key: keys[index]),
                                        ),
                                        Expanded(child: Container()),
                                        Text(
                                          model.dateCreate,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(model.textColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Flexible(
                                      child: Text(
                                        model.titleNote,
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Color(model.textColor),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        model.textNote,
                                        maxLines: 6,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w300,
                                          color: Color(model.textColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
