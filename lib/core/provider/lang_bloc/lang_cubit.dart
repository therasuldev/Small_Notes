import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/service/preference_service.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(const LangState());

  Future<void> initApp() async {
    final lang = await currentLang;

    emit(state.copyWith(langCode: lang));
  }

  Future<String?> get currentLang async {
    final appLang = await PrefService.preferences.get('lang');
    log('yeni $appLang');

    return appLang ?? 'az';
  }

  Future<void> changeLang(dynamic newLang) async {
    try {
      await PrefService.preferences.put('lang', newLang);
      emit(state.copyWith(langCode: newLang));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
