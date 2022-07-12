import 'dart:developer';

import 'package:smallnotes/core/model/note_model.dart';
import 'package:smallnotes/core/service/note_service.dart';

class DBNHelper {
  final service = NoteService.noteService;

  Future<List<NoteModel>> addNote(dynamic key, NoteModel model) async {
    await service.put(key, model);
    return getNotes();
  }

  List<NoteModel> getNotes() {
    var values = service.values.toList();
    return values as List<NoteModel>;
  }

  Future<List<NoteModel>> removeNote(dynamic key) async {
    await service.delete(key);
    return getNotes();
  }

  Future<List<NoteModel>> updateNote(dynamic key, NoteModel model) async {
    await service.put(key, model);

    return getNotes();
  }
}
