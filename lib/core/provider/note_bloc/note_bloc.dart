import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/database/notes_database.dart';
import 'package:smallnotes/core/model/note_model.dart';

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
      final model = await dbnHelper.addNote(event.key,event.model);
      emit(Success(model: model));
    } catch (message) {
      emit(Error(message: message.toString()));
    }
  }

  void _onGetNoteEvent(GetNoteEvent event, Emitter<NotesState> emit) async {
    try {
      emit(Loading());
      final model = dbnHelper.getNotes();
      emit(Success(model: model));
    } catch (message) {
      emit(Error(message: message.toString()));
    }
  }

  void _onRemoveNoteEvent(
      RemoveNoteEvent event, Emitter<NotesState> emit) async {
    try {
      emit(Loading());
      final model = await dbnHelper.removeNote(event.key);
      emit(Success(model: model));
    } catch (message) {
      emit(Error(message: message.toString()));
    }
  }

  void _onUpdateNoteEvent(
      UpdateNoteEvent event, Emitter<NotesState> emit) async {
    try {
      emit(Loading());
      final model = await dbnHelper.updateNote(event.key, event.model);
      emit(Success(model: model));
    } catch (message) {
      emit(Error(message: message.toString()));
    }
  }
}
