import 'package:music/db/dao/music_dao.dart';
import 'package:music/db/db_help.dart';
import 'package:sqflite/sqflite.dart';

/// 酷狗
class KGMusicDao extends MusicDao {
  /// 插入数据
  @override
  Future<int> insert(Map<String, Object?> map) async {
    Database? database;
    try {
      database = await DbHelp().getDatabase();
      return await database.insert(DbHelp.tableKuGou, map);
    } catch (e) {
      database?.close();
    }
    return 0;
  }

  /// 删除数据
  @override
  Future<int> delete(int id) async {
    Database? database;
    try {
      database = await DbHelp().getDatabase();
      return await database.delete(
        DbHelp.tableKuGou,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      database?.close();
    }
    return 0;
  }

  /// 查询数据
  @override
  Future<List<Map<String, Object?>>> query() async {
    Database? database;
    try {
      database = await DbHelp().getDatabase();
      var map = await database.query(DbHelp.tableKuGou);
      return map;
    } catch (e) {
      database?.close();
    }
    return [];
  }
}
