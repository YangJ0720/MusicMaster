import 'dart:collection';
import 'dart:convert';

import 'package:music/model/music_parser.dart';

import 'music_model.dart';

/// 酷我
class KWMusicParser extends MusicParser {

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
      var rid = e['rid'];
      return MusicModel(
        songName,
        singerName,
        MusicModel.platformKuWo,
        rid: rid,
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
    map['rid'] = model.rid;
    return map;
  }
}