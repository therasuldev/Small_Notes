part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent extends Equatable {}

class AddToFavoritesEvent extends FavoriteEvent {
  final dynamic id;
  final dynamic value;

  AddToFavoritesEvent(this.id, this.value);
  @override
  List<Object?> get props => [id, value];
}

class GetFavoritesEvent extends FavoriteEvent {
  @override
  List<Object?> get props => [];
}

class UpdateFavoriteEvent extends FavoriteEvent {
  final dynamic id;
  final dynamic value;

  UpdateFavoriteEvent(this.id, this.value);
  @override
  List<Object?> get props => [id, value];
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final dynamic id;

  RemoveFavoriteEvent({this.id});
  @override
  List<Object?> get props => [id];
}
