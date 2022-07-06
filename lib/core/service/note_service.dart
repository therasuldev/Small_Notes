import 'package:hive_flutter/hive_flutter.dart';
import 'package:smallnotes/core/service/service.dart';

class NoteService extends SuperService {
  static Box get noteService => Hive.box('allNotes');

  //
  static bool get isNPreferencesSetted => noteService.isNotEmpty;
}
