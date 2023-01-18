import 'package:music/model/kg_music_parser.dart';
import 'package:music/model/music_model.dart';
import 'package:music/network/api/api_base.dart';
import 'package:music/network/http_client.dart';

/// 酷狗
class ApiBaseKg extends ApiBase {
  @override
  Future<List<MusicModel>?> search(String keyword) async {
    var path = 'https://mobiles.kugou.com/api/v3/search/song?format=jsonp'
        '&keyword=$keyword&page=1&pagesize=30&showtype=1';
    var response = await HttpClient.get(path);
    if (response == null) return null;
    // 移除响应结果的括号
    var space = 1;
    //
    var length = response.length;
    return KGMusicParser().parser(response.substring(space, length - space));
  }
}
