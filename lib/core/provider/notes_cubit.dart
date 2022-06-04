import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/database/notes_database.dart';

part 'notes_state.dart';

class NoteModel {
  String id;
  String titleNote;
  String textNote;
  String dateCreate;
  int backgroundColor;
  int textColor;

  NoteModel({
    required this.id,
    required this.titleNote,
    required this.textNote,
    required this.dateCreate,
    required this.backgroundColor,
    required this.textColor,
  });
}

class FavoriteModel {
  String id;
  String titleNote;
  String textNote;
  String dateCreate;
  int backgroundColor;
  int textColor;
  FavoriteModel({
    required this.id,
    required this.titleNote,
    required this.textNote,
    required this.dateCreate,
    required this.backgroundColor,
    required this.textColor,
  });
}

class NotesCubit extends Cubit<NotesState> {
  List<NoteModel> _item = [];
  List<FavoriteModel> _favoriteItem = [];

  NotesCubit(super.initialState);

  List<NoteModel> get item => _item;
  List<FavoriteModel> get favoriteItem => _favoriteItem;

  //database
  Future insertDatabase({
    required String id,
    required String titleNote,
    required String textNote,
    required String dateCreate,
    required int backgroundColor,
    required int textColor,
  }) async {
    emit(NoteLoading());
    try {
      final noteItem = NoteModel(
        id: id,
        titleNote: titleNote,
        textNote: textNote,
        dateCreate: dateCreate,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );
      _item.add(noteItem);

      DBHelper.insert(
        DBHelper.note,
        {
          'id': noteItem.id,
          'titleNote': noteItem.titleNote,
          'textNote': noteItem.textNote,
          'dateCreate': noteItem.dateCreate,
          'backgroundColor': noteItem.backgroundColor,
          'textColor': noteItem.textColor,
        },
      );
      emit(NoteSuccess());
    } catch (e) {
      log(e.toString());
      emit(NoteFailed());
    }
  }

  Future<void> selectNote() async {
    emit(NoteLoading());
    try {
      final dataList = await DBHelper.selectNote(DBHelper.note);
      _item = dataList
          .map(
            (item) => NoteModel(
              id: item['id'],
              titleNote: item['titleNote'],
              textNote: item['textNote'],
              dateCreate: item['dateCreate'],
              backgroundColor: item['backgroundColor'],
              textColor: item['textColor'],
            ),
          )
          .toList();
      emit(NoteSuccess());
    } catch (e) {
      log(e.toString());
      emit(NoteFailed());
    }
  }

  Future<void> deleteNoteById(pickId) async {
    emit(NoteLoading());
    try {
      await DBHelper.deleteById(DBHelper.note, 'id', pickId);
      emit(NoteSuccess());
    } catch (e) {
      log(e.toString());
      emit(NoteFailed());
    }
  }

  Future deleteTable() async {
    emit(NoteLoading());
    try {
      await DBHelper.deleteTable(DBHelper.note);
      emit(NoteSuccess());
    } catch (e) {
      log(e.toString());
      emit(NoteFailed());
    }
  }

  Future<void> updateNoteNameById(
    id,
    String textNote,
    String titleNote,
    String dateCreate,
  ) async {
    emit(NoteLoading());
    try {
      final db = await DBHelper.database();
      await db.update(
        DBHelper.note,
        {
          'id': id,
          'textNote': textNote,
          'titleNote': titleNote,
          'dateCreate': dateCreate,
        },
        where: "id = ?",
        whereArgs: [id],
      );
      emit(NoteSuccess());
    } catch (e) {
      log(e.toString());
      emit(NoteFailed());
    }
  }
  //!===========Favorite Table================

  Future insertFavoriteToDatabase({
    required String id,
    required String titleNote,
    required String textNote,
    required String dateCreate,
    required int backgroundColor,
    required int textColor,
  }) async {
    emit(NoteLoading());
    try {
      final favoriteNoteItem = FavoriteModel(
        id: id,
        titleNote: titleNote,
        textNote: textNote,
        dateCreate: dateCreate,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );
      _favoriteItem.add(favoriteNoteItem);

      DBHelper.insert(
        DBHelper.favorite,
        {
          'id': favoriteNoteItem.id,
          'titleNote': favoriteNoteItem.titleNote,
          'textNote': favoriteNoteItem.textNote,
          'dateCreate': favoriteNoteItem.dateCreate,
          'backgroundColor': favoriteNoteItem.backgroundColor,
          'textColor': favoriteNoteItem.textColor,
        },
      );
      emit(NoteSuccess());
    } catch (e) {
      log(e.toString());
      emit(NoteFailed());
    }
  }

  Future<void> selectFavoriteNote() async {
    emit(NoteLoading());
    try {
      final dataList = await DBHelper.selectNote(DBHelper.favorite);
      _favoriteItem = dataList
          .map(
            (favoriteItem) => FavoriteModel(
              id: favoriteItem['id'],
              titleNote: favoriteItem['titleNote'],
              textNote: favoriteItem['textNote'],
              dateCreate: favoriteItem['dateCreate'],
              backgroundColor: favoriteItem['backgroundColor'],
              textColor: favoriteItem['textColor'],
            ),
          )
          .toList();
      emit(NoteSuccess());
    } catch (e) {
      log(e.toString());
      emit(NoteFailed());
    }
  }

  Future<void> deleteFavoriteNoteById(pickId) async {
    emit(NoteLoading());
    try {
      await DBHelper.deleteById(DBHelper.favorite, 'id', pickId);
      emit(NoteSuccess());
    } catch (e) {
      log(e.toString());
      emit(NoteFailed());
    }
  }

  Future deleteFavoriteTable() async {
    emit(NoteLoading());
    try {
      await DBHelper.deleteTable(DBHelper.favorite);
      emit(NoteSuccess());
    } catch (e) {
      log(e.toString());
      emit(NoteFailed());
    }
  }

  Future<void> updateFavoriteNoteById(
    id,
    String textNote,
    String titleNote,
    String dateCreate,
  ) async {
    emit(NoteLoading());
    try {
      final db = await DBHelper.database();
      await db.update(
        DBHelper.favorite,
        {
          'id': id,
          'textNote': textNote,
          'titleNote': titleNote,
          'dateCreate': dateCreate,
        },
        where: "id = ?",
        whereArgs: [id],
      );
      emit(NoteSuccess());
    } catch (e) {
      log(e.toString());
      emit(NoteFailed());
    }
  }
}
