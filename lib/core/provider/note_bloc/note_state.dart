part of 'note_bloc.dart';

@immutable
abstract class NotesState extends Equatable {}

class Empty extends NotesState {
  @override
  List<Object?> get props => [];
}

class Loading extends NotesState {
  @override
  List<Object?> get props => [];
}

class Success extends NotesState {
  final dynamic keys;
  final dynamic values;
  final List<dynamic>? item;

  Success({this.keys, this.values, this.item});
  @override
  List<Object?> get props => [item,keys,values];
}

class Error extends NotesState {
  final String message;

  Error({required this.message});
  @override
  List<Object?> get props => [message];
}
