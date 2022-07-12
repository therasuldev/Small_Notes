import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smallnotes/core/app/intl.dart';
import 'package:smallnotes/core/database/favorite_notes_database.dart';
import 'package:smallnotes/core/database/notes_database.dart';
import 'package:smallnotes/core/provider/favorite_bloc/favorite_bloc.dart';
import 'package:smallnotes/core/provider/lang_bloc/lang_cubit.dart';
import 'package:smallnotes/core/provider/note_bloc/note_bloc.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

import 'constant/app_color.dart';
import 'constant/app_route.dart';
import 'core/provider/isGrid_view/grid_cubit.dart';

class MyApp extends NoteStatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends NoteState<MyApp> {
  final AppRoute appRoute = AppRoute();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotesBloc(dbnHelper: DBNHelper())),
        BlocProvider(create: (context) => FavoriteBloc(dbfHelper: DBFHelper())),
        BlocProvider(create: (context) => LangCubit()..initApp()),
        BlocProvider(create: (context) => GridCubit()..initApp()),
      ],
      child: BlocBuilder<LangCubit, LangState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                elevation: 0.5,
                backgroundColor: AppColors.brownLight,
                iconTheme: IconThemeData(color: AppColors.brown),
              ),
              scaffoldBackgroundColor: AppColors.white,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: appRoute.appRoutes.keys.first,
            routes: appRoute.appRoutes,
            title: 'Small Colored Notes',
            localizationsDelegates: [
              note.intl.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: languages.map((lang) => Locale(lang, '')),
            locale: Locale(state.langCode ?? note.intl.locale.languageCode),
          );
        },
      ),
    );
  }
}
