import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/database/favorite_notes_database.dart';

import '../../model/note_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final DBFHelper dbfHelper;
  FavoriteBloc({required this.dbfHelper}) : super(FavoriteEmpty()) {
    on<AddToFavoritesEvent>(_onAddToFavoritesEvent);
    on<GetFavoritesEvent>(_onGetFavoritesEvent);
    on<UpdateFavoriteEvent>(_onUpdateFavoriteEvent);
    on<RemoveFavoriteEvent>(_onRemoveFavoriteEvent);
  }
  void _onAddToFavoritesEvent(
      AddToFavoritesEvent event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteLoading());
      final model = await dbfHelper.addToFavorites(event.key,event.model);
      emit(FavoriteSuccess(model: model));
    } catch (message) {
      emit(FavoriteError(message: message.toString()));
    }
  }

  void _onGetFavoritesEvent(
      GetFavoritesEvent event, Emitter<FavoriteState> emit) {
    try {
      emit(FavoriteLoading());
      final model = dbfHelper.getFavorites();
      emit(FavoriteSuccess(model: model));
    } catch (message) {
      emit(FavoriteError(message: message.toString()));
    }
  }

  void _onUpdateFavoriteEvent(
      UpdateFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteLoading());
      final model = await dbfHelper.updateFavoriteNote(event.key, event.model);
      emit(FavoriteSuccess(model: model));
    } catch (message) {
      emit(FavoriteError(message: message.toString()));
    }
  }

  void _onRemoveFavoriteEvent(
      RemoveFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteLoading());
      final model = await dbfHelper.removeFavorite(event.key);
      emit(FavoriteSuccess(model: model));
    } catch (message) {
      emit(FavoriteError(message: message.toString()));
    }
  }
}
