
import 'package:music/model/music_model.dart';

abstract class MusicParser {

  List<MusicModel> parser(String string);

  Map<String, Object?> toMap(MusicModel model);

}