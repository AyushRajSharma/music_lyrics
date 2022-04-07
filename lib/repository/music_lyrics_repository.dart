import 'package:music_lyrics/constants.dart';
import 'package:music_lyrics/models/music_lyrics.dart';
import 'package:music_lyrics/networking/api_provider.dart';
import 'dart:async';

class MusicLyricsRepository {
  final int trackId;
  MusicLyricsRepository({required this.trackId});
  ApiProvider _provider = ApiProvider();
  Future<MusicLyrics> fetchMusicDetailsData() async {
    final response = await _provider
        .get("https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=$apikey");
    return MusicLyrics.fromJson(response);
  }
}
