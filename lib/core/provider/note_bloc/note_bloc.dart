import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/database/notes_database.dart';

part 'note_event.dart';
part 'note_state.dart';

class NotesBloc extends Bloc<NoteEvent, NotesState> {
  final DBNHelper dbnHelper;

  NotesBloc({required this.dbnHelper}) : super(Empty()) {
    on<AddNoteEvent>(_onAddNoteEvent);
    on<GetNoteEvent>(_onGetNoteEvent);
    on<RemoveNoteEvent>(_onRemoveNoteEvent);
    on<UpdateNoteEvent>(_onUpdateNoteEvent);
  }
  void _onAddNoteEvent(AddNoteEvent event, Emitter<NotesState> emit) async {
    try {
      emit(Loading());
      final result = await dbnHelper.addNote(event.id, event.values);
      emit(Success(item: result));
    } catch (message) {
      emit(Error(message: message.toString()));
    }
  }

  void _onGetNoteEvent(GetNoteEvent event, Emitter<NotesState> emit) async {
    try {
      emit(Loading());
      final result = await dbnHelper.getNotes();
      emit(Success(keys: result[0], values: result[1]));
    } catch (message) {
      emit(Error(message: message.toString()));
    }
  }

  void _onRemoveNoteEvent(
      RemoveNoteEvent event, Emitter<NotesState> emit) async {
    try {
      emit(Loading());
      final result = await dbnHelper.removeNote(event.id);
      emit(Success(keys: result[0], values: result[1]));
    } catch (message) {
      emit(Error(message: message.toString()));
    }
  }

  void _onUpdateNoteEvent(
      UpdateNoteEvent event, Emitter<NotesState> emit) async {
    try {
      emit(Loading());
      final result = await dbnHelper.updateNote(event.id, event.values);
      emit(Success(keys: result[0], values: result[1]));
    } catch (message) {
      emit(Error(message: message.toString()));
    }
  }
}
