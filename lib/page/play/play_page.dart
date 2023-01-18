import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music/db/dao/kg_music_dao.dart';
import 'package:music/model/list/play_list_model.dart';
import 'package:music/widget/list_checkbox_view.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final StreamController<PlayListModel> _controller = StreamController();

  Future<void> _loadData() async {
    var dao = KGMusicDao();
    var list = await dao.query();
    var model = PlayListModel.fromList(list);
    _controller.sink.add(model);
  }

  Widget? _createLeadingView(bool isEditor, bool isChecked, callback) {
    if (isEditor) {
      return ListCheckboxView(isChecked, callback: () => callback?.call());
    }
    return null;
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
    return Scaffold(
      appBar: AppBar(title: Text(DateTime.now().toIso8601String())),
      body: StreamBuilder<PlayListModel>(
        builder: (_, snapshot) {
          var data = snapshot.requireData;
          var list = data.list;
          var isEditor = data.isEditor;
          return ListView.builder(
            itemBuilder: (_, index) {
              var item = list[index];
              var id = item.id;
              var isChecked = data.contains(id);
              return ListTile(
                leading: _createLeadingView(
                  isEditor,
                  isChecked,
                  () {
                    data.change(id);
                    _controller.sink.add(data);
                  },
                ),
                title: Text(item.songName),
                subtitle: Text(item.singerName),
                onLongPress: () {
                  if (isEditor) return;
                  data.isEditor = true;
                  _controller.sink.add(data);
                },
              );
            },
            itemCount: list.length,
          );
        },
        stream: _controller.stream,
        initialData: PlayListModel([]),
      ),
    );
  }
}
