part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent extends Equatable {}

class AddToFavoritesEvent extends FavoriteEvent {
  final dynamic key;
  final NoteModel model;

  AddToFavoritesEvent({required this.key, required this.model});
  @override
  List<Object?> get props => [key ,model];
}

class GetFavoritesEvent extends FavoriteEvent {
  @override
  List<Object?> get props => [];
}

class UpdateFavoriteEvent extends FavoriteEvent {
  final dynamic key;
  final NoteModel model;

  UpdateFavoriteEvent({required this.key, required this.model});
  @override
  List<Object?> get props => [key, model];
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final dynamic key;

  RemoveFavoriteEvent({required this.key});
  @override
  List<Object?> get props => [key];
}
