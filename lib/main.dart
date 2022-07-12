import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smallnotes/app.dart';
import 'package:smallnotes/core/app/intl.dart';
import 'package:smallnotes/core/app/note.dart';
import 'package:smallnotes/core/model/note_model.dart';
import 'package:smallnotes/core/service/preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(NoteModelAdapter());
  final Note note = Note();

  await Hive.initFlutter();
  await Hive.openBox<NoteModel>('AllNotes');
  await Hive.openBox<NoteModel>('Favorites');
  await Hive.openBox('preferences');
  await Hive.openBox('isGrid');

  note.intl = Intl();
  note.prefService = PrefService();
  note.intl.locale = const Locale('az');
  note.intl.supportedLocales = languages;

  runApp(MyApp());
}
