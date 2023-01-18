
import 'dart:collection';
import 'dart:convert';

import 'package:music/model/music_model.dart';
import 'package:music/model/music_parser.dart';

/// 酷狗
class KGMusicParser extends MusicParser {

  @override
  List<MusicModel> parser(String string) {
    var jsonObject = json.decode(string);
    var data = jsonObject['data'];
    if (data == null) return [];
    var info = data['info'];
    return List.from(info).map((e) {
      var songName = e['songname'];
      var singerName = e['singername'];
      //
      var albumId = e['album_id'];
      var albumAudioId = e['album_audio_id'];
      var hash = e['hash'];
      return MusicModel(
        songName,
        singerName,
        MusicModel.platformKuGou,
        albumId: albumId,
        albumAudioId: albumAudioId,
        hash: hash,
      );
    }).toList();
  }

  @override
  Map<String, Object?> toMap(MusicModel model) {
    var map = HashMap<String, Object?>();
    map['singerName'] = model.singerName;
    map['singerImage'] = model.singerImage;
    map['songName'] = model.songName;
    map['songImage'] = model.songImage;
    //
    map['album_id'] = model.albumId;
    map['album_audio_id'] = model.albumAudioId;
    map['hash'] = model.hash;
    return map;
  }
}