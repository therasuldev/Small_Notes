import 'package:smallnotes/core/service/note_service.dart';

class DBNHelper {
  final service = NoteService.noteService;

  Future<dynamic> addNote(String id, Map<dynamic, dynamic> values) async {
    return await service.put(id, values);
  }

  Future<List<dynamic>> getNotes() async {
    var keys = service.keys.toList();
    var values = service.values.toList();
    List allNotes = [
      [...keys],
      [...values]
    ];
    return allNotes;
  }

  Future<List<dynamic>> removeNote(String key) async {
    await service.delete(key);
    var keys = service.keys.toList();
    var values = service.values.toList();
    List remainingNotes = [
      [...keys],
      [...values]
    ];
    return remainingNotes;
  }

  Future<List<dynamic>> updateNote(
      String id, Map<dynamic, dynamic> value) async {
    await service.put(id, value);
    var keys = service.keys.toList();
    var values = service.values.toList();
    List newNotes = [
      [...keys],
      [...values]
    ];
    return newNotes;
  }
}
