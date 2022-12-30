import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music/data/music_data.dart';

class HomeTabView extends StatefulWidget {
  final MusicData data;

  const HomeTabView(this.data, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> with AutomaticKeepAliveClientMixin {
  final StreamController<List<HotData>> _controller = StreamController();

  /// 加载数据
  Future<void> _loadData() async {
    var list = await widget.data.init();
    _controller.sink.add(list);
  }

  List<Widget> _createItemView(HotData data) {
    List<Widget> list = [];
    var image = data.image;
    if (image == null || image.isEmpty) {
      list.add(const Expanded(child: Icon(Icons.error)));
    } else {
      list.add(Expanded(child: Image.network(image)));
    }
    list.add(Text(data.name));
    return list;
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
    super.build(context);
    return StreamBuilder<List<HotData>>(
      builder: (_, snapshot) {
        var data = snapshot.requireData;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (_, index) {
            var item = data[index];
            return Column(children: _createItemView(item));
          },
          itemCount: data.length,
        );
      },
      stream: _controller.stream,
      initialData: const [],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
