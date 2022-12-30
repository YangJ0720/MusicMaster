import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            child: Center(child: CircleAvatar(child: Text('杨'))),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(leading: Icon(Icons.settings), title: Text('设置')),
          ListTile(leading: Icon(Icons.help), title: Text('关于')),
        ],
        padding: EdgeInsets.zero,
      ),
    );
  }
}
