import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  /// 加载数据
  Future<void> _loadData(String text) async {
    var url = 'http://msearchcdn.kugou.com/';
    var base = BaseOptions(baseUrl: url);
    var dio = Dio(base);
    var sb = StringBuffer();
    sb.write('api/v3/search/song?showtype=14&highlight=em');
    sb.write('&pagesize=30&tag_aggr=1&tagtype=全部&plat=0&sver=5');
    sb.write('&keyword=$text&correct=1&api_ver=1&version=9108&page=1');
    sb.write('&area_code=1&tag=1&with_res_tag=1');
    var path = sb.toString();
    var response = await dio.get<String>(path);
    debugPrint('response = $response');
    var code = response.statusCode;
    if (code == 200) {
      var responseData = response.data;
      if (responseData == null) return;
      var s = '<!--KG_TAG_RES_START-->';
      var e = '<!--KG_TAG_RES_END-->';
      // 去除头部标识
      if (responseData.startsWith(s)) {
        responseData = responseData.substring(s.length);
      }
      // 去除尾部标识
      if (responseData.endsWith(e)) {
        var length = responseData.length;
        responseData = responseData.substring(0, length - e.length);
      }
      debugPrint('responseData = $responseData');
    }
  }

  @override
  void dispose() {
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
            onPressed: () => _loadData(_controller.text),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return ListTile(title: Text(index.toString()));
        },
        itemCount: 100,
      ),
    );
  }
}
