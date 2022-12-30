abstract class MusicData {
  final List<HotData> list = [];

  Future<List<HotData>> init();
}

class HotData {
  final int id;
  final String name;
  final String? image;

  HotData(this.id, this.name, this.image);

  @override
  String toString() {
    return 'HotData{id: $id, name: $name, image: $image}';
  }
}
