import 'package:hive_flutter/hive_flutter.dart';
import 'package:smallnotes/core/model/note_model.dart';
import 'package:smallnotes/core/service/service.dart';

class FavoriteService extends SuperService {
  static Box get favoriteService => Hive.box<NoteModel>('Favorites');

  //
  static bool get isFPreferencesSetted => favoriteService.isNotEmpty;
}
