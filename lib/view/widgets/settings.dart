import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smallnotes/core/provider/lang_bloc/lang_cubit.dart';
import 'package:smallnotes/core/provider/note_bloc/note_bloc.dart';
import 'package:smallnotes/core/service/note_service.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

import '../../constant/app_color.dart';
import '../../constant/app_size.dart';
import '../../core/provider/isGrid_view/grid_cubit.dart';
import '../../core/provider/isGrid_view/grid_state.dart';
import 'pop_up_menu_bar.dart';

class Settings extends NoteStatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends NoteState<Settings> {
  late LangCubit langCubit;
  late GridCubit gridCubit;

  @override
  void initState() {
    langCubit = BlocProvider.of<LangCubit>(context);
    gridCubit = BlocProvider.of<GridCubit>(context);
    BlocProvider.of<NotesBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              BlocBuilder<LangCubit, LangState>(
                builder: (context, state) {
                  return Container(
                    height: 50,
                    width: size(context).width * .9,
                    decoration: ViewUtils.settingsCard(),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.green.withOpacity(.7)),
                          child: const Icon(Icons.language),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          note.fmt(context, 'app.lang'),
                          style: const TextStyle(fontSize: 16),
                        ),
                        Expanded(child: Container()),
                        PopUpMenuBar(
                          baseIcon: Icons.select_all,
                          iconColor: AppColors.blueGrey,
                          items: [
                            PopUpMenuBarItem(
                              title: note.fmt(context, 'lang.az'),
                              tralling: const Text(
                                '🇦🇿',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            PopUpMenuBarItem(
                              title: note.fmt(context, 'lang.ru'),
                              tralling: const Text(
                                '🇷🇺',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                          onSelect: (i) async {
                            final values = {0: 'az', 1: 'ru'};
                            if (state.langCode == values[i]) return;

                            await langCubit.changeLang(values[i]);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<GridCubit, GridState>(
                builder: (context, state) {
                  return Container(
                    height: 50,
                    width: size(context).width * .9,
                    decoration: ViewUtils.settingsCard(),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.blue.withOpacity(.7)),
                          child: const Icon(Icons.grid_view),
                        ),
                        const SizedBox(width: 5),
                         Text(
                          note.fmt(context, 'settings.grid'),
                          style: TextStyle(fontSize: 16),
                        ),
                        Expanded(child: Container()),
                        PopUpMenuBar(
                          baseIcon: Icons.select_all,
                          iconColor: AppColors.blueGrey,
                          items:  [
                            PopUpMenuBarItem(
                              title: note.fmt(context, 'grid.view'),
                              tralling: Icon(Icons.grid_view),
                            ),
                            PopUpMenuBarItem(
                              title: note.fmt(context, 'list'),
                              tralling: Icon(Icons.list),
                            ),
                          ],
                          onSelect: (i) async {
                            final values = {0: true, 1: false};
                            if (state.isGrid == values[i]) return;

                            await gridCubit.changeView(values[i]!);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return ViewUtils.generateDialog(
                        context,
                        title: 'Bütün qeydlər, ayarlar silinəcəkdir',
                        cancelTitle: note.fmt(context, 'dialog.close'),
                        actTitle: note.fmt(context, 'dialog.check'),
                        onAct: () async {
                          var keys = NoteService.noteService.keys;
                          NoteService.noteService.deleteAll(keys);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: Container(
                  height: 50,
                  width: size(context).width * .9,
                  decoration: ViewUtils.settingsCard(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.darkYellow.withOpacity(.9)),
                        child: const Icon(Icons.delete_sweep),
                      ),
                      const SizedBox(width: 5),
                       Text(
                        note.fmt(context, 'settings.cache'),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => SystemNavigator.pop(),
                child: Container(
                  height: 50,
                  width: size(context).width * .9,
                  decoration: ViewUtils.settingsCard(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.redO.withOpacity(.8)),
                        child: const Icon(Icons.logout_rounded),
                      ),
                      const SizedBox(width: 5),
                      Text(note.fmt(context, 'settings.exit'), style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
               Padding(
                 padding: const EdgeInsets.only(bottom: 40.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: AssetImage('assets/img/notes.png'))),

                      ),
                      const SizedBox(width: 5),
                       Text(note.fmt(context, 'team'), style: GoogleFonts.rubikMoonrocks(fontSize: 20)),
                    ],
                  ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
