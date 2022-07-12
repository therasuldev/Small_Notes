part of 'lang_cubit.dart';

class LangState {
  final String? langCode;

  const LangState({this.langCode});

  LangState copyWith({String? langCode}) {
    return LangState(langCode: langCode ?? this.langCode);
  }

  static get empty => const LangState();
}
