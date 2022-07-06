import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/provider/favorite_bloc/favorite_bloc.dart';
import 'package:smallnotes/core/provider/note_bloc/note_bloc.dart';
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
  final String noData = 'assets/lottie/empty.json';
  int selectedTileIndex = 0;
  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(GetNoteEvent());
    BlocProvider.of<FavoriteBloc>(context).add(GetFavoritesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownLight,
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          final nProvider = BlocProvider.of<NotesBloc>(context);
          final fProvider = BlocProvider.of<FavoriteBloc>(context);
          if (state is Loading) {
            return Center(
                child: CircularProgressIndicator(color: AppColors.blueGrey));
          }
          if (state is Success) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              children: [
                const Padding(padding: EdgeInsets.only(top: 15)),
                Column(
                  children: [
                    _statisticsFavLen(
                        noteProvider: nProvider, favoriteProvider: fProvider),
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                    // state.keys[0]==''
                    //     ? Lottie.asset(noData, repeat: false)
                    //     :
                    ListView.builder(
                      controller: _scrollController,
                      itemCount: state.keys?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = state.values[index];
                        final selectedTile = selectedTileIndex == index;
                        return FadeAnimation(
                          delay: index / (index + 3),
                          child: Dismissible(
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                return showDialog(
                                  context: context,
                                  builder: (_) {
                                    return ViewUtils.generateDialog(
                                      context,
                                      title: note.fmt(context, 'deleted.note'),
                                      cancelTitle:
                                          note.fmt(context, 'dialog.close'),
                                      actTitle:
                                          note.fmt(context, 'dialog.check'),
                                      onAct: () {
                                        context.read<NotesBloc>().add(
                                            RemoveNoteEvent(
                                                id: state.keys[index]));
                                        context.read<FavoriteBloc>().add(
                                            RemoveFavoriteEvent(
                                                id: state.keys[index]));
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              }
                              return false;
                            },
                            key: ValueKey(state.keys[index]),
                            background: Container(color: AppColors.red),
                            secondaryBackground:
                                Container(color: AppColors.green),
                            child: InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    selectedTileIndex = index;
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (_) {
                                      return ShowItem(
                                          isPage: true,
                                          id: state.keys[index],
                                          getTitleNote: item['titleNote'],
                                          getTextNote: item['textNote'],
                                          getDateCreate: item['dateCreate'],
                                          getBackgroundColor:
                                              item['backgroundColor'],
                                          getTextColor: item['textColor']);
                                    }), (route) => true);
                                  },
                                );
                              },
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  decoration: ViewUtils.kDecor(
                                      color: selectedTile
                                          ? AppColors.blueGrey
                                              .withOpacity(.6)
                                              .value
                                          : item[
                                              'backgroundColor'], //helper.backgroundColor,
                                      bR: 7,
                                      tL: 7,
                                      tR: 7,
                                      bL: 7),
                                  height: 70,
                                  width: size(context).width,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                width: size(context).width * .7,
                                                height: 30,
                                                color: AppColors.transparent,
                                                child: Text(
                                                  item['titleNote'],
                                                  style: TextStyle(
                                                      color: Color(
                                                          item['textColor']),
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Text(item['dateCreate'],
                                                style: TextStyle(
                                                    color: Color(
                                                        item['textColor']),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 1),
                                          ],
                                        ),
                                        Text(
                                          item['textNote'],
                                          style: TextStyle(
                                              color: Color(item['textColor']),
                                              fontSize: 16),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ])),
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                    ),
                  ],
                )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Row _statisticsFavLen({
    required NotesBloc noteProvider,
    required FavoriteBloc favoriteProvider,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NoteNum(numN: noteProvider.dbnHelper.service.keys.length),
        FavoriteNum(numF: favoriteProvider.dbfHelper.service.keys.length),
      ],
    );
  }
}
