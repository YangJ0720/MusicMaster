import 'package:music/db/dao/kg_music_dao.dart';
import 'package:music/db/dao/kw_music_dao.dart';
import 'package:music/model/music_model.dart';

abstract class MusicDao {

  static MusicDao? build(int platform) {
    switch (platform) {
      case MusicModel.platformKuGou:
        return KGMusicDao();
      case MusicModel.platformKuWo:
        return KWMusicDao();
      default:
        break;
    }
    return null;
  }

  /// 插入数据
  Future<int> insert(Map<String, Object?> map);

  /// 删除数据
  Future<int> delete(int id);

  /// 查询数据
  Future<List<Map<String, Object?>>> query();
}
