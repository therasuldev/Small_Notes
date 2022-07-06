part of 'note_bloc.dart';

@immutable
abstract class NoteEvent extends Equatable {}

class AddNoteEvent extends NoteEvent {
  final dynamic id;
  final Map<dynamic, dynamic> values;

  AddNoteEvent({required this.id, required this.values});

  @override
  List<Object?> get props => [id, values];
}

class GetNoteEvent extends NoteEvent {
  final dynamic id;
  GetNoteEvent({this.id});
  @override
  List<Object?> get props => [id];
}

class RemoveNoteEvent extends NoteEvent {
  final dynamic id;

  RemoveNoteEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class UpdateNoteEvent extends NoteEvent {
  final String id;
  final Map<String, dynamic> values;

  UpdateNoteEvent({required this.id, required this.values});
  @override
  List<Object?> get props => [id, values];
}
