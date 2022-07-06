import 'package:flutter/material.dart';
import 'package:smallnotes/core/service/preference_service.dart';
import 'package:smallnotes/core/utils/logger.dart';

import 'intl.dart';

class Note {
  static final Note _singleton = Note._internal();

  final Map<String, dynamic> instances = {};

  factory Note() => _singleton;

  Note._internal() {
    Log.v('${runtimeType.toString()} instance created');
  }

  set intl(Intl intl) => instances['intl'] = intl;
  Intl get intl => instances['intl'];

  set prefService(PrefService service) => instances['prefService'] = service;
  PrefService get prefService => instances['prefService'];

  String fmt(BuildContext context, String key, [List? args]) {
    return intl.of(context)?.fmt(key, args) ?? '';
  }
}

@immutable
abstract class NoteAppModel {
  const NoteAppModel();

  const NoteAppModel.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}

typedef ItemCreator<S> = S Function();
