import 'dart:async';
import 'package:music_lyrics/networking/response.dart';
import 'package:music_lyrics/repository/music_list_repository.dart';
import 'package:music_lyrics/models/music_list.dart';

class MusicListBloc {
  late MusicListRepository _musicListRepository;
  late StreamController<Response<MusicList>> _musicListController;

  StreamSink<Response<MusicList>> get musicListSink =>
      _musicListController.sink;

  Stream<Response<MusicList>> get musicListStream =>
      _musicListController.stream;

  MusicListBloc() {
    _musicListController = StreamController<Response<MusicList>>.broadcast();
    _musicListRepository = MusicListRepository();
    fetchMusicList();
  }

  fetchMusicList() async {
    musicListSink.add(Response.loading('Loading list. '));
    try {
      MusicList musicList = await _musicListRepository.fetchMusicListData();
      musicListSink.add(Response.completed(musicList));
    } catch (e) {
      musicListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _musicListController.close();
  }
}
