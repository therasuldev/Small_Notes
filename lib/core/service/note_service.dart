import 'package:hive_flutter/hive_flutter.dart';
import 'package:smallnotes/core/model/note_model.dart';
import 'package:smallnotes/core/service/service.dart';

class NoteService extends SuperService {
  static Box<NoteModel> get noteService => Hive.box<NoteModel>('AllNotes');

  //
  static bool get isNPreferencesSetted => noteService.isNotEmpty;
}
