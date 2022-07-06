import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/provider/lang_bloc/lang_cubit.dart';
import 'package:smallnotes/view/constant/app_size.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

import 'pop_up_menu_bar.dart';

class Settings extends NoteStatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends NoteState<Settings> {
  late LangCubit langCubit;

  @override
  void initState() {
    langCubit = BlocProvider.of<LangCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: BlocBuilder<LangCubit, LangState>(
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: size(context).width * .9,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.3),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Icon(Icons.language),
                        const SizedBox(width: 3),
                        Text(note.fmt(context, 'app.lang')),
                        Expanded(child: Container()),
                        PopUpMenuBar(
                          baseIcon: Icons.select_all,
                          iconColor: Colors.blueGrey,
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
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
