import 'package:music/model/music_model.dart';

class MusicPlatformUtils {
  static const Map<int, String> _map = {
    MusicModel.platformWangYi: '网易',
    MusicModel.platformQQ: 'QQ',
    MusicModel.platformKuGou: '酷狗',
    MusicModel.platformKuWo: '酷我',
  };

  static String platformToString(int platform) {
    var value = _map[platform];
    if (value == null) return '未知';
    return value;
  }
}
