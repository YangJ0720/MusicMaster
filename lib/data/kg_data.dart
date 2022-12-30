import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music/data/music_data.dart';

class KGData extends MusicData {
  @override
  Future<List<HotData>> init() async {
    var url = 'http://mobilecdnbj.kugou.com/';
    var base = BaseOptions(baseUrl: url);
    var dio = Dio(base);
    var path = 'api/v3/tag/recommend?showtype=3&apiver=2&plat=0';
    var response = await dio.request<String>(path);
    debugPrint('response = $response');
    var code = response.statusCode;
    if (code == 200) {
      var responseData = response.data;
      if (responseData == null) return list;
      var map = json.decode(responseData);
      var data = map['data'];
      debugPrint('data = $data');
      var info = data['info'];
      debugPrint('info = $info');
      //
      if (list.isNotEmpty) list.clear();
      //
      info.forEach((element) {
        var id = element['id'];
        var name = element['name'];
        var image = element['bannerurl'];
        list.add(HotData(id, name, image));
      });
    }
    return list;
  }
}
