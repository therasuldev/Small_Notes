import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
class NoteModel with _$NoteModel {
  factory NoteModel({
    required String titleNote,
    required String textNote,
    required String dateCreate,
    required int backgroundColor,
    required int textColor,
  }) = _NoteModel;
  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
}
