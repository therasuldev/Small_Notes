import 'package:smallnotes/core/service/favorite_service.dart';

import '../model/note_model.dart';

class DBFHelper {
  final service = FavoriteService.favoriteService;

  Future<List<NoteModel>> addToFavorites(dynamic key ,NoteModel model) async {
    await service.put(key,model);
    return getFavorites();
  }

  List<NoteModel> getFavorites() {
    var model = service.values.toList();
    return model as List<NoteModel>;
  }

  Future<List<NoteModel>> removeFavorite(dynamic key) async {
    await service.delete(key);
    return getFavorites();
  }

  Future<List<NoteModel>> updateFavoriteNote(dynamic key, NoteModel model) async {
    await service.put(key, model);
    return getFavorites();
  }
}
