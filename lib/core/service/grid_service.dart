import 'package:hive/hive.dart';
import 'package:smallnotes/core/service/service.dart';

class GridService extends SuperService {
  static Box get gridService => Hive.box('isGrid');

  //
  static bool get isGPreferencesSetted => gridService.isNotEmpty;
}
