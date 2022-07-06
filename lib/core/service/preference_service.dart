import 'package:hive_flutter/hive_flutter.dart';
import 'package:smallnotes/core/service/service.dart';

class PrefService extends SuperService {
  static Box get preferences => Hive.box('preferences');

  //
  static bool get isPreferencesSetted => preferences.isNotEmpty;
}
