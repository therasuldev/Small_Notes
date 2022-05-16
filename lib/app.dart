import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smallnotes/core/app/intl.dart';
import 'package:smallnotes/core/provider/notes.dart';
import 'package:smallnotes/view/constant/color_constant.dart';
import 'package:smallnotes/view/general_home.dart';
import 'package:smallnotes/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MyApp extends NoteStatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends NoteState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
      ],
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: AppColors.brown),
          scaffoldBackgroundColor: AppColors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: GeneralHome(),
        localizationsDelegates: [
          note.intl.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: languages.map((lang) => Locale(lang, '')),
        locale: Locale(note.intl.locale.languageCode),
      ),
    );
  }
}
