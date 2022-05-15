import 'package:flutter/material.dart';
import 'package:littleNotes/app.dart';
import 'package:littleNotes/core/app/intl.dart';
import 'package:littleNotes/core/app/note.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Note note = Note();
  note.intl = Intl();
  note.intl.locale = const Locale('az');
  note.intl.supportedLocales = languages;

  runApp(MyApp());
}
