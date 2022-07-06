// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'note_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) {
  return _NoteModel.fromJson(json);
}

/// @nodoc
mixin _$NoteModel {
  String get titleNote => throw _privateConstructorUsedError;
  String get textNote => throw _privateConstructorUsedError;
  String get dateCreate => throw _privateConstructorUsedError;
  int get backgroundColor => throw _privateConstructorUsedError;
  int get textColor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteModelCopyWith<NoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteModelCopyWith<$Res> {
  factory $NoteModelCopyWith(NoteModel value, $Res Function(NoteModel) then) =
      _$NoteModelCopyWithImpl<$Res>;
  $Res call(
      {String titleNote,
      String textNote,
      String dateCreate,
      int backgroundColor,
      int textColor});
}

/// @nodoc
class _$NoteModelCopyWithImpl<$Res> implements $NoteModelCopyWith<$Res> {
  _$NoteModelCopyWithImpl(this._value, this._then);

  final NoteModel _value;
  // ignore: unused_field
  final $Res Function(NoteModel) _then;

  @override
  $Res call({
    Object? titleNote = freezed,
    Object? textNote = freezed,
    Object? dateCreate = freezed,
    Object? backgroundColor = freezed,
    Object? textColor = freezed,
  }) {
    return _then(_value.copyWith(
      titleNote: titleNote == freezed
          ? _value.titleNote
          : titleNote // ignore: cast_nullable_to_non_nullable
              as String,
      textNote: textNote == freezed
          ? _value.textNote
          : textNote // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreate: dateCreate == freezed
          ? _value.dateCreate
          : dateCreate // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as int,
      textColor: textColor == freezed
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_NoteModelCopyWith<$Res> implements $NoteModelCopyWith<$Res> {
  factory _$$_NoteModelCopyWith(
          _$_NoteModel value, $Res Function(_$_NoteModel) then) =
      __$$_NoteModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String titleNote,
      String textNote,
      String dateCreate,
      int backgroundColor,
      int textColor});
}

/// @nodoc
class __$$_NoteModelCopyWithImpl<$Res> extends _$NoteModelCopyWithImpl<$Res>
    implements _$$_NoteModelCopyWith<$Res> {
  __$$_NoteModelCopyWithImpl(
      _$_NoteModel _value, $Res Function(_$_NoteModel) _then)
      : super(_value, (v) => _then(v as _$_NoteModel));

  @override
  _$_NoteModel get _value => super._value as _$_NoteModel;

  @override
  $Res call({
    Object? titleNote = freezed,
    Object? textNote = freezed,
    Object? dateCreate = freezed,
    Object? backgroundColor = freezed,
    Object? textColor = freezed,
  }) {
    return _then(_$_NoteModel(
      titleNote: titleNote == freezed
          ? _value.titleNote
          : titleNote // ignore: cast_nullable_to_non_nullable
              as String,
      textNote: textNote == freezed
          ? _value.textNote
          : textNote // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreate: dateCreate == freezed
          ? _value.dateCreate
          : dateCreate // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as int,
      textColor: textColor == freezed
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NoteModel implements _NoteModel {
  _$_NoteModel(
      {required this.titleNote,
      required this.textNote,
      required this.dateCreate,
      required this.backgroundColor,
      required this.textColor});

  factory _$_NoteModel.fromJson(Map<String, dynamic> json) =>
      _$$_NoteModelFromJson(json);

  @override
  final String titleNote;
  @override
  final String textNote;
  @override
  final String dateCreate;
  @override
  final int backgroundColor;
  @override
  final int textColor;

  @override
  String toString() {
    return 'NoteModel(titleNote: $titleNote, textNote: $textNote, dateCreate: $dateCreate, backgroundColor: $backgroundColor, textColor: $textColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NoteModel &&
            const DeepCollectionEquality().equals(other.titleNote, titleNote) &&
            const DeepCollectionEquality().equals(other.textNote, textNote) &&
            const DeepCollectionEquality()
                .equals(other.dateCreate, dateCreate) &&
            const DeepCollectionEquality()
                .equals(other.backgroundColor, backgroundColor) &&
            const DeepCollectionEquality().equals(other.textColor, textColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(titleNote),
      const DeepCollectionEquality().hash(textNote),
      const DeepCollectionEquality().hash(dateCreate),
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(textColor));

  @JsonKey(ignore: true)
  @override
  _$$_NoteModelCopyWith<_$_NoteModel> get copyWith =>
      __$$_NoteModelCopyWithImpl<_$_NoteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NoteModelToJson(this);
  }
}

abstract class _NoteModel implements NoteModel {
  factory _NoteModel(
      {required final String titleNote,
      required final String textNote,
      required final String dateCreate,
      required final int backgroundColor,
      required final int textColor}) = _$_NoteModel;

  factory _NoteModel.fromJson(Map<String, dynamic> json) =
      _$_NoteModel.fromJson;

  @override
  String get titleNote => throw _privateConstructorUsedError;
  @override
  String get textNote => throw _privateConstructorUsedError;
  @override
  String get dateCreate => throw _privateConstructorUsedError;
  @override
  int get backgroundColor => throw _privateConstructorUsedError;
  @override
  int get textColor => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_NoteModelCopyWith<_$_NoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}
