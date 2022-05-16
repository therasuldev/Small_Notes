import 'package:flutter/material.dart';
import 'package:smallnotes/app.dart';
import 'package:smallnotes/core/app/intl.dart';
import 'package:smallnotes/core/app/note.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Note note = Note();
  note.intl = Intl();
  note.intl.locale = const Locale('az');
  note.intl.supportedLocales = languages;

  runApp(MyApp());
}
