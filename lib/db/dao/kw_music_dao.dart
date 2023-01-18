import 'package:music/db/dao/music_dao.dart';
import 'package:music/db/db_help.dart';
import 'package:sqflite/sqlite_api.dart';

class KWMusicDao extends MusicDao {

  @override
  Future<int> insert(Map<String, Object?> map) async {
    Database? database;
    try {
      database = await DbHelp().getDatabase();
      return await database.insert(DbHelp.tableKuWo, map);
    } catch (e) {
      database?.close();
    }
    return 0;
  }

  @override
  Future<int> delete(int id) async {
    Database? database;
    try {
      database = await DbHelp().getDatabase();
      return await database.delete(
        DbHelp.tableKuWo,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      database?.close();
    }
    return 0;
  }

  @override
  Future<List<Map<String, Object?>>> query() async {
    Database? database;
    try {
      database = await DbHelp().getDatabase();
      var map = await database.query(DbHelp.tableKuWo);
      return map;
    } catch (e) {
      database?.close();
    }
    return [];
  }

}