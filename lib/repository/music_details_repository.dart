import 'package:music_lyrics/constants.dart';
import 'package:music_lyrics/models/music_details.dart';
import 'package:music_lyrics/networking/api_provider.dart';
import 'dart:async';

class MusicDetailsRepository {
  final int trackId;
  MusicDetailsRepository({required this.trackId});
  ApiProvider _provider = ApiProvider();
  Future<MusicDetails> fetchMusicDetailsData() async {
    final response =
        await _provider.get("https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackId&apikey=$apikey");
    return MusicDetails.fromJson(response);
  }
}
