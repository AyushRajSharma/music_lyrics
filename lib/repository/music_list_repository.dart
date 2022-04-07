import 'package:music_lyrics/constants.dart';
import 'package:music_lyrics/networking/api_provider.dart';
import 'dart:async';
import 'package:music_lyrics/models/music_list.dart';

class MusicListRepository {
  ApiProvider _provider = ApiProvider();
  Future<MusicList> fetchMusicListData() async {
    final response = await _provider.get("https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$apikey");
    return MusicList.fromJson(response);
  }
}
