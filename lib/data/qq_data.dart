import 'package:music/data/music_data.dart';

class QQData extends MusicData {
  @override
  Future<List<HotData>> init() async {
    return list;
  }
}
