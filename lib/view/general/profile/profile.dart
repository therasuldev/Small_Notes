import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:smallnotes/core/model/note_model.dart';
import 'package:smallnotes/core/provider/favorite_bloc/favorite_bloc.dart';
import 'package:smallnotes/core/provider/isGrid_view/grid_cubit.dart';
import 'package:smallnotes/core/provider/note_bloc/note_bloc.dart';
import 'package:smallnotes/core/service/favorite_service.dart';
import 'package:smallnotes/core/service/note_service.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/general/profile/show_item.dart';
import 'package:smallnotes/view/widgets/utils.dart';

import 'components/number_of_notes.dart';

class Profile extends NoteStatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends NoteState<Profile> {
  late GridCubit gridCubit;
  final ScrollController _scrollController = ScrollController();
  final String noData = 'assets/lottie/empty.json';
  var fService = FavoriteService.favoriteService;
  var nService = NoteService.noteService;

  int selectedTileIndex = 0;
  bool? isGridV = false;
  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(GetNoteEvent());
    BlocProvider.of<FavoriteBloc>(context).add(GetFavoritesEvent());
    gridCubit = BlocProvider.of<GridCubit>(context);
    _getView();
    super.initState();
  }

  _getView() async {
    isGridV = await gridCubit.currentView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownLight,
      body: _body(),
    );
  }

  Widget _body() {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is Loading) {
          return _bodyLOADING();
        }
        if (state is Success) {
          return _bodySUCCESS(state);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _bodyLOADING() {
    return Center(
      child: CircularProgressIndicator(color: AppColors.blueGrey),
    );
  }

  Widget _bodySUCCESS(Success state) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const Padding(padding: EdgeInsets.only(top: 15)),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AllNoteNum(numN: nService.keys.length),
                FavoriteNum(numF: fService.keys.length),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 15)),
            state.model.isEmpty
                ? Lottie.asset(noData, repeat: false)
                : isGridV!
                    ? GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        controller: _scrollController,
                        children: List.generate(
                          state.model.length,
                          (int index) {
                            final keys = nService.keys.toList();
                            final model = state.model[index];
                            final selectedTile = selectedTileIndex == index;
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 2,
                              duration: const Duration(milliseconds: 350),
                              child: ScaleAnimation(
                                child: _generalNoteContainer(
                                    index, context, keys, model, selectedTile),
                              ),
                            );
                          },
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: state.model.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final keys = nService.keys.toList();
                          final model = state.model[index];
                          final selectedTile = selectedTileIndex == index;
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: 1,
                            duration: const Duration(milliseconds: 350),
                            child: FadeInAnimation(
                              child: _generalNoteContainer(
                                  index, context, keys, model, selectedTile),
                            ),
                          );
                        },
                      ),
          ],
        )
      ],
    );
  }

  Widget _generalNoteContainer(
    int index,
    BuildContext context,
    List<dynamic> keys,
    NoteModel model,
    bool selectedTile,
  ) {
    return Dismissible(
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return showDialog(
            context: context,
            builder: (_) {
              return ViewUtils.generateDialog(
                context,
                title: note.fmt(context, 'deleted.note'),
                cancelTitle: note.fmt(context, 'dialog.close'),
                actTitle: note.fmt(context, 'dialog.check'),
                onAct: () {
                  context
                      .read<NotesBloc>()
                      .add(RemoveNoteEvent(key: keys[index]));
                  context
                      .read<FavoriteBloc>()
                      .add(RemoveFavoriteEvent(key: keys[index]));
                  Navigator.pop(context);
                },
              );
            },
          );
        }
        return false;
      },
      key: ValueKey('$index'),
      background: Container(color: AppColors.red),
      secondaryBackground: Container(color: AppColors.transparent),
      child: GestureDetector(
        onTap: () {
          setState(() => selectedTileIndex = index);
          rTlRoute(
              context: context,
              route: ShowItem(
                  isPage: true,
                  id: keys[index],
                  getTitleNote: model.titleNote,
                  getTextNote: model.textNote,
                  getDateCreate: model.dateCreate,
                  getBackgroundColor: model.backgroundColor,
                  getTextColor: model.textColor),
              back: true);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: ViewUtils.itemCard(
            borderColor: selectedTile ? AppColors.blackAccent.value : null,
            color: model.backgroundColor,
          ),
          width: isGridV! ? 200 : size(context).width,
          height: isGridV! ? 200 : 70,
          child: isGridV! ? gridBuilder(model) : listBuilder(context, model),
        ),
      ),
    );
  }

  Widget listBuilder(BuildContext context, NoteModel model) {
    return Column(
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
                  model.titleNote,
                  style: TextStyle(color: Color(model.textColor), fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Text(
              model.dateCreate,
              maxLines: 1,
              style: TextStyle(
                  color: Color(model.textColor),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          model.textNote,
          maxLines: 1,
          style: TextStyle(color: Color(model.textColor), fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget gridBuilder(NoteModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 200,
          height: 40,
          color: AppColors.transparent,
          alignment: Alignment.topLeft,
          child: Text(
            model.titleNote,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(model.textColor),
              fontSize: 17,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 200,
          height: 122,
          color: AppColors.transparent,
          child: Text(
            model.textNote,
            maxLines: 6,
            style: TextStyle(
              color: Color(model.textColor),
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
            width: 200,
            height: 27,
            color: AppColors.transparent,
            alignment: Alignment.topRight,
            child: Text(
              model.dateCreate,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(model.textColor),
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
