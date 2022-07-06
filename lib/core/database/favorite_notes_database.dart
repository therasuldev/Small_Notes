import 'package:smallnotes/core/service/favorite_service.dart';

class DBFHelper {
  final service = FavoriteService.favoriteService;

  Future<dynamic> addToFavorites(
      String id, Map<dynamic, dynamic> values) async {
    return await service.put(id, values);
  }

  Future<List<dynamic>> getFavorites() async {
    var keys = service.keys.toList();
    var values = service.values.toList();
    List allFavoriteNotes = [
      [...keys],
      [...values]
    ];
    return allFavoriteNotes;
  }

  Future<List<dynamic>> removeFavorite(String key) async {
    await service.delete(key);
    var keys = service.keys.toList();
    var values = service.values.toList();
    List remainingNotes = [
      [...keys],
      [...values]
    ];
    return remainingNotes;
  }

  Future<List<dynamic>> updateFavoriteNote(
      String id, Map<dynamic, dynamic> value) async {
    await service.put(id, value);
    var keys = service.keys.toList();
    var values = service.values.toList();
    List newFavoriteNote = [
      [...keys],
      [...values]
    ];
    return newFavoriteNote;
  }
}
