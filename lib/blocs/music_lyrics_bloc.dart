import 'dart:async';
import 'package:music_lyrics/networking/response.dart';
import 'package:music_lyrics/repository/music_lyrics_repository.dart';
import 'package:music_lyrics/models/music_lyrics.dart';
import 'package:flutter/cupertino.dart';

class MusicLyricsBloc {
  late MusicLyricsRepository _musicLyricsRepository;
  late StreamController<Response<MusicLyrics>> _musicLyricsController;
  int trackId;
  StreamSink<Response<MusicLyrics>> get musicLyricsSink =>
      _musicLyricsController.sink;

  Stream<Response<MusicLyrics>> get musicLyricsStream =>
      _musicLyricsController.stream;

  MusicLyricsBloc({required this.trackId}) {
    _musicLyricsController =
        StreamController<Response<MusicLyrics>>.broadcast();
    _musicLyricsRepository = MusicLyricsRepository(trackId: trackId);
    fetchMusicLyrics();
  }
  fetchMusicLyrics() async {
    musicLyricsSink.add(Response.loading('Loading lyrics'));
    try {
      MusicLyrics musicLyrics =
          await _musicLyricsRepository.fetchMusicDetailsData();
      musicLyricsSink.add(Response.completed(musicLyrics));
    } catch (e) {
      musicLyricsSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _musicLyricsController.close();
  }
}
