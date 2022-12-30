import 'package:flutter/material.dart';
import 'package:music/data/kg_data.dart';
import 'package:music/data/qq_data.dart';
import 'package:music/page/home/drawer/home_drawer.dart';
import 'package:music/page/home/tab/home_tab_view.dart';
import 'package:music/page/search/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List<Tab> _tabs = [
    const Tab(text: '我的'),
    const Tab(text: '网易'),
    const Tab(text: 'QQ'),
    const Tab(text: '酷狗'),
    const Tab(text: '酷我'),
  ];
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _tabs.length, vsync: this);
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
        title: InkWell(
          child: Container(
            child: const Text(
              '周杰伦',
              style: TextStyle(color: Colors.black),
            ),
            decoration: const BoxDecoration(color: Colors.white),
            width: double.infinity,
          ),
          onTap: () {
            var route = MaterialPageRoute(builder: (_) => const SearchPage());
            Navigator.push(context, route);
          },
        ),
        bottom: TabBar(tabs: _tabs, controller: _controller),
      ),
      body: TabBarView(
        children: [
          HomeTabView(QQData()),
          HomeTabView(QQData()),
          HomeTabView(QQData()),
          HomeTabView(KGData()),
          HomeTabView(QQData()),
        ],
        controller: _controller,
      ),
      drawer: const HomeDrawer(),
    );
  }
}
