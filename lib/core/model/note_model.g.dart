// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NoteModel _$$_NoteModelFromJson(Map<String, dynamic> json) => _$_NoteModel(
      titleNote: json['titleNote'] as String,
      textNote: json['textNote'] as String,
      dateCreate: json['dateCreate'] as String,
      backgroundColor: json['backgroundColor'] as int,
      textColor: json['textColor'] as int,
    );

Map<String, dynamic> _$$_NoteModelToJson(_$_NoteModel instance) =>
    <String, dynamic>{
      'titleNote': instance.titleNote,
      'textNote': instance.textNote,
      'dateCreate': instance.dateCreate,
      'backgroundColor': instance.backgroundColor,
      'textColor': instance.textColor,
    };
