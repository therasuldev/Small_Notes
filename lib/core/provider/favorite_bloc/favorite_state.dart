part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState extends Equatable {}

class FavoriteEmpty extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteLoading extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteSuccess extends FavoriteState {
  final dynamic item;
  final dynamic keys;
  final dynamic values;

  FavoriteSuccess({this.item, this.keys, this.values});
  @override
  List<Object?> get props => [item, keys, values];
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});
  @override
  List<Object?> get props => [message];
}
