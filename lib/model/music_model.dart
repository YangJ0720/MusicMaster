import 'package:music/model/kg_music_parser.dart';
import 'package:music/model/kw_music_parser.dart';

class MusicModel {
  /// 网易
  static const platformWangYi = 1;

  /// QQ
  static const platformQQ = 2;

  /// 酷狗
  static const platformKuGou = 3;

  /// 酷我
  static const platformKuWo = 4;

  String songName;
  String? songImage;
  String singerName;
  String? singerImage;
  int platform;

  /// 酷狗
  String? albumId;
  int? albumAudioId;
  String? hash;

  /// 酷我
  String? rid;

  MusicModel(
    this.songName,
    this.singerName,
    this.platform, {
    this.songImage,
    this.singerImage,

    /// 酷狗
    this.albumId,
    this.albumAudioId,
    this.hash,

    /// 酷我
    this.rid,
  });

  Map<String, Object?>? toMap() {
    Map<String, Object?>? hashMap;
    switch (platform) {
      case platformKuGou:
        hashMap = KGMusicParser().toMap(this);
        break;
      case platformKuWo:
        hashMap = KWMusicParser().toMap(this);
        break;
      default:
        break;
    }
    return hashMap;
  }
}