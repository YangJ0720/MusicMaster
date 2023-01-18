import 'package:sqflite/sqflite.dart';

class DbHelp {
  static const _dbName = 'database.db';
  static const _dbVersion = 1;

  static const tableWangYi = 'WangYi';
  static const tableQQ = 'QQ';
  static const tableKuGou = 'KuGou';
  static const tableKuWo = 'KuWo';

  Future<Database>? _database;

  Future<Database> _initialize() async {
    return await openDatabase(
      _dbName,
      version: _dbVersion,
      onCreate: (Database db, int version) {
        db.execute(
          'CREATE TABLE $tableKuGou (id INTEGER PRIMARY KEY, '
          'songName TEXT, songImage TEXT, '
          'singerName TEXT, singerImage TEXT, '
          'album_id TEXT, album_audio_id INTEGER, hash TEXT, '
          'UNIQUE (songName, singerName))',
        );
        db.execute(
          'CREATE TABLE $tableKuWo (id INTEGER PRIMARY KEY, '
              'songName TEXT, songImage TEXT, '
              'singerName TEXT, singerImage TEXT, '
              'rid TEXT, '
              'UNIQUE (songName, singerName))',
        );
      },
    );
  }

  Future<Database> getDatabase() async {
    var database = _database;
    if (database == null) {
      database ??= _initialize();
      _database = database;
    }
    return database;
  }
}
