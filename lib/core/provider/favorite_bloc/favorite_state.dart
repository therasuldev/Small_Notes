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
  final List<NoteModel> model;

  FavoriteSuccess({required this.model});
  @override
  List<Object?> get props => [model];
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});
  @override
  List<Object?> get props => [message];
}
