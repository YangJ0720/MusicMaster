class PlayListModel {
  List<PlayListItem> list;
  bool isEditor;
  Map<int, bool> selects = {};

  PlayListModel(this.list, {this.isEditor = false});

  factory PlayListModel.fromList(List<Map<String, Object?>> l) {
    var list = List.from(l).map((e) => PlayListItem.fromMap(e)).toList();
    return PlayListModel(list);
  }

  bool contains(int id) => selects[id] == true;

  void change(int id) {
    var isChecked = selects[id];
    if (isChecked == true) {
      selects[id] = false;
    } else {
      selects[id] = true;
    }
  }

  void reset() {
    isEditor = false;
    selects.clear();
  }
}

class PlayListItem {
  int id;
  String songName;
  String? songImage;
  String singerName;
  String? singerImage;
  //
  String? albumId;
  int? albumAudioId;
  String? hash;

  PlayListItem(
    this.id,
    this.songName,
    this.singerName, {
    this.songImage,
    this.singerImage,
    this.albumId,
    this.albumAudioId,
    this.hash,
  });

  factory PlayListItem.fromMap(Map<String, dynamic> map) {
    var id = map['id'];
    var songName = map['songName'] ?? '';
    var songImage = map['songImage'];
    var singerName = map['singerName'] ?? '';
    var singerImage = map['singerImage'];
    var albumId = map['album_id'];
    var albumAudioId = map['album_audio_id'];
    var hash = map['hash'];
    return PlayListItem(
      id,
      songName,
      singerName,
      songImage: songImage,
      singerImage: singerImage,
      albumId: albumId,
      albumAudioId: albumAudioId,
      hash: hash,
    );
  }

}
