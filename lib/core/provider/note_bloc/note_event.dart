part of 'note_bloc.dart';

@immutable
abstract class NoteEvent extends Equatable {}

class AddNoteEvent extends NoteEvent {
  final dynamic key;
  final NoteModel model;

  AddNoteEvent({required this.model, required this.key});

  @override
  List<Object?> get props => [key,model];
}

class GetNoteEvent extends NoteEvent {
  @override
  List<Object?> get props => [];
}

class RemoveNoteEvent extends NoteEvent {
  final dynamic key;

  RemoveNoteEvent({required this.key});
  @override
  List<Object?> get props => [key];
}

class UpdateNoteEvent extends NoteEvent {
  final dynamic key;
  final NoteModel model;

  UpdateNoteEvent({required this.key, required this.model});
  @override
  List<Object?> get props => [key, model];
}
