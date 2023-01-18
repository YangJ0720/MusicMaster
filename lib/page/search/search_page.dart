import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music/db/dao/music_dao.dart';
import 'package:music/model/kg_music_parser.dart';
import 'package:music/model/music_model.dart';
import 'package:music/network/api/api_base_kg.dart';
import 'package:music/network/http_client.dart';
import 'package:music/utils/music_platform_utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey();
  final StreamController<List<MusicModel>> _streamC = StreamController();
  final TextEditingController _controller = TextEditingController();

  /// 下拉刷新
  Future<void> onRefresh() async {
    var keyword = _controller.text;
    var list = await ApiBaseKg().search(keyword);
    if (list == null) return;
    _streamC.sink.add(list);
  }

  Widget _createPlatformView(int platform) {
    return Container(
      child: Text(
        MusicPlatformUtils.platformToString(platform),
        style: const TextStyle(color: Colors.white, fontSize: 8),
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(0.5)),
        color: Colors.blue,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5),
    );
  }

  @override
  void dispose() {
    _streamC.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: const InputDecoration(),
        ),
        actions: [
          IconButton(
            onPressed: () => _key.currentState?.show(),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _key,
        child: StreamBuilder<List<MusicModel>>(
          builder: (_, snapshot) {
            var list = snapshot.requireData;
            return ListView.separated(
              itemBuilder: (_, index) {
                var item = list[index];
                var platform = item.platform;
                return InkWell(
                  child: Container(
                    child: Row(
                      children: [
                        _createPlatformView(platform),
                        Column(
                          children: [
                            Text(item.songName, maxLines: 1),
                            Text(item.singerName),
                          ],
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ],
                      mainAxisSize: MainAxisSize.min,
                    ),
                    decoration: const BoxDecoration(),
                  ),
                  onTap: () {
                    var map = item.toMap();
                    if (map == null) return;
                    MusicDao.build(platform)?.insert(map);
                  },
                );
              },
              separatorBuilder: (_, index) => const Divider(),
              itemCount: list.length,
            );
          },
          stream: _streamC.stream,
          initialData: const [],
        ),
        onRefresh: onRefresh,
      ),
    );
  }
}
