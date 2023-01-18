import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music/db/dao/kg_music_dao.dart';
import 'package:music/model/list/play_list_model.dart';
import 'package:music/network/http_client.dart';

class MusicListView extends StatefulWidget {
  const MusicListView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MusicListViewState();
}

class _MusicListViewState extends State<MusicListView> {
  final StreamController<PlayListModel> _controller = StreamController();

  /// 加载歌曲列表
  Future<void> _loadData() async {
    var dao = KGMusicDao();
    var list = await dao.query();
    var model = PlayListModel.fromList(list);
    _controller.sink.add(model);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: StreamBuilder<PlayListModel>(
        builder: (_, snapshot) {
          var data = snapshot.requireData;
          var list = data.list;
          return ListView.builder(
            itemBuilder: (_, index) {
              var item = list[index];
              return ListTile(
                title: Text(item.songName),
                subtitle: Text(item.singerName),
                trailing: IconButton(
                  onPressed: () async {
                    var id = await KGMusicDao().delete(item.id);
                    if (id > 0) {
                      list.removeAt(index);
                      _controller.sink.add(data);
                    }
                  },
                  icon: const Icon(Icons.close),
                ),
                onTap: () {
                  var path = 'https://m.kugou.com/app/i/getSongInfo.php?'
                      'cmd=playInfo&hash=${item.hash}';
                  HttpClient.get(path).then((value) {
                    print('value = $value');
                  });
                },
              );
            },
            itemCount: list.length,
          );
        },
        stream: _controller.stream,
        initialData: PlayListModel([]),
      ),
      color: Colors.white,
      width: size.width,
      height: size.height * 0.5,
    );
  }
}
