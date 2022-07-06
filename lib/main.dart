import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smallnotes/app.dart';
import 'package:smallnotes/core/app/intl.dart';
import 'package:smallnotes/core/app/note.dart';
import 'package:smallnotes/core/service/preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Note note = Note();

  await Hive.initFlutter();
  await Hive.openBox('allNotes');
  await Hive.openBox('favorites');
  await Hive.openBox('preferences');

  note.intl = Intl();
  note.prefService = PrefService();
  note.intl.locale = const Locale('az');
  note.intl.supportedLocales = languages;

  runApp(MyApp());
}
