import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/database/favorite_notes_database.dart';

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
      final result = await dbfHelper.addToFavorites(event.id, event.value);
      emit(FavoriteSuccess(item: result));
    } catch (message) {
      emit(FavoriteError(message: message.toString()));
    }
  }

  void _onGetFavoritesEvent(
      GetFavoritesEvent event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteLoading());
      final result = await dbfHelper.getFavorites();
      emit(FavoriteSuccess(keys: result[0], values: result[1]));
    } catch (message) {
      emit(FavoriteError(message: message.toString()));
    }
  }

  void _onUpdateFavoriteEvent(
      UpdateFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteLoading());
      final result = await dbfHelper.updateFavoriteNote(event.id, event.value);
      emit(FavoriteSuccess(values: result[1]));
    } catch (message) {
      emit(FavoriteError(message: message.toString()));
    }
  }

  void _onRemoveFavoriteEvent(
      RemoveFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteLoading());
      final result = await dbfHelper.removeFavorite(event.id);
      emit(FavoriteSuccess(keys: result[0], values: result[1]));
    } catch (message) {
      emit(FavoriteError(message: message.toString()));
    }
  }
}
