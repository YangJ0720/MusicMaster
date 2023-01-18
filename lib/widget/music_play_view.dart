import 'package:flutter/material.dart';
import 'package:music/widget/music_list_view.dart';

class MusicPlayView extends StatefulWidget {
  const MusicPlayView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MusicPlayViewState();
}

class _MusicPlayViewState extends State<MusicPlayView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const Text('周杰伦'),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next)),
          IconButton(
            onPressed: () {
              var view = const MusicListView();
              showModalBottomSheet(context: context, builder: (_) => view);
            },
            icon: const Icon(Icons.format_list_bulleted),
          ),
        ],
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2.5)),
        color: Colors.blueGrey,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
