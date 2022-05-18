import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const note = "NotesOfficial";

  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, "NotesOfficial"),
      onCreate: (db, version) {
        db.execute("CREATE TABLE IF NOT EXISTS $note(id TEXT PRIMARY KEY ,"
            " titleNote TEXT,"
            " dateCreate TEXT,"
            " textColor INTEGER,"
            " backgroundColor INTEGER,"
            " textNote TEXT)");
      },
      version: 1,
    );
  }

  static Future insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    return db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> selectAll(
    String table,
    dynamic order,
  ) async {
    final db = await DBHelper.database();
    return db.query(
      table,
      orderBy: order,
    );
  }

  static Future<void> deleteById(
    String table,
    String columnId,
    String id,
  ) async {
    final db = await DBHelper.database();
    await db.delete(
      table,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  static Future deleteTable(String table) async {
    final db = await DBHelper.database();
    return db.rawDelete("DELETE FROM $table");
  }

  static Future selectNoteById(String id) async {
    final db = await DBHelper.database();
    return await db.rawQuery(
      "SELECT * from ${DBHelper.note} where id = ? ",
      [id],
    );
  }

  static Future<List<Map<String, dynamic>>> selectNote() async {
    final db = await DBHelper.database();
    var select = await db.query(DBHelper.note);
    return select;
  }
}
