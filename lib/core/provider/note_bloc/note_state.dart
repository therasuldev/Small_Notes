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
  final List<NoteModel> model;

  Success({required this.model});

  @override
  List<Object?> get props => [model];
}

class Error extends NotesState {
  final String message;

  Error({required this.message});
  @override
  List<Object?> get props => [message];
}
