part of 'lang_cubit.dart';

class LangState {
  final String? langCode;

  final String? error;

  const LangState({
    this.langCode,
    this.error,
  });

  LangState copyWith({
    String? langCode,
    String? error,
  }) {
    return LangState(
      langCode: langCode ?? this.langCode,
      error: error ?? this.error,
    );
  }

  static get empty => const LangState();
}
