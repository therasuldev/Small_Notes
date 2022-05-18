import 'package:flutter/material.dart';
import 'package:smallnotes/core/database/notes_database.dart';
import 'package:uuid/uuid.dart';

class NoteModel {
  String id;
  String titleNote;
  String textNote;
  String dateCreate;
  int backgroundColor;
  int textColor;

  NoteModel({
    required this.id,
    required this.backgroundColor,
    required this.titleNote,
    required this.textNote,
    required this.dateCreate,
    required this.textColor,
  });
}

class NoteProvider extends ChangeNotifier {
  List<NoteModel> _item = [];

  List<NoteModel> get item => _item;

  //database
  Future insertDatabase(
    int backgroundColor,
    int textColor,
    String titleNote,
    String textNote,
    String dateCreate,
  ) async {
    final noteItem = NoteModel(
      id: const Uuid().v1(),
      titleNote: titleNote,
      textNote: textNote,
      backgroundColor: backgroundColor,
      textColor: textColor,
      dateCreate: dateCreate,
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
        'textColor':textColor,
      },
    );

    notifyListeners();
  }

  Future<void> selectNote() async {
    final dataList = await DBHelper.selectNote();
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
    notifyListeners();
  }

  Future<void> deleteNoteById(pickId) async {
    await DBHelper.deleteById(DBHelper.note, 'id', pickId);
    notifyListeners();
  }

  Future deleteTable() async {
    await DBHelper.deleteTable(DBHelper.note);
    notifyListeners();
  }

  Future<void> updateNoteNameById(id, String noteName) async {
    final db = await DBHelper.database();
    await db.update(
      DBHelper.note,
      {'noteName': noteName},
      where: "id = ?",
      whereArgs: [id],
    );
    notifyListeners();
  }
}
