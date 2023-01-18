import 'package:music/model/music_model.dart';

abstract class ApiBase {
  /// 搜索
  Future<List<MusicModel>?> search(String keyword);

}