import 'dart:async';
import 'package:music_lyrics/networking/response.dart';
import 'package:music_lyrics/repository/music_details_repository.dart';
import 'package:music_lyrics/models/music_details.dart';


class MusicDetailsBloc {
  late MusicDetailsRepository _musicDetailsRepository;
  late StreamController<Response<MusicDetails>> _musicDetailsController;
  int trackId;
  StreamSink<Response<MusicDetails>> get musicDetailsSink =>
      _musicDetailsController.sink;

  Stream<Response<MusicDetails>> get musicDetailsStream =>
      _musicDetailsController.stream;

  MusicDetailsBloc({required this.trackId}) {
    _musicDetailsController =
        StreamController<Response<MusicDetails>>.broadcast();
    _musicDetailsRepository = MusicDetailsRepository(trackId: trackId);
    //fetchMusicDetails();
  }
  fetchMusicDetails() async {
    musicDetailsSink.add(Response.loading('Loading details.. '));
    try {
      MusicDetails musicDetails =
          await _musicDetailsRepository.fetchMusicDetailsData();
      musicDetailsSink.add(Response.completed(musicDetails));
    } catch (e) {
      musicDetailsSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _musicDetailsController.close();
  }
}
