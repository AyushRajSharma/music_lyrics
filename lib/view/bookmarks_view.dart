import 'package:music_lyrics/view/music_list_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_lyrics/models/music_list.dart' as ListTrack;

class BookmarkView extends StatefulWidget {
  @override
  _BookmarkViewState createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
   List<String>? trackIdList;
  late List<String> trackNameList;
  late List<String> trackAlbumList;
  late List<String> trackArtistList;
  @override
  void initState() {
    super.initState();
    sharedPref();

  }

  void sharedPref() async {
    final perfs = await SharedPreferences.getInstance();
    setState(() {
      trackIdList = perfs.getStringList('bookmarkList')!;
      trackNameList = perfs.getStringList('nameList')!;
      trackAlbumList = perfs.getStringList('albumList')!;
      trackAlbumList = perfs.getStringList('artistList')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    sharedPref();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Bookmarks',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,

      body: (trackIdList == null || trackIdList?.length == 0)
          ? Container(
            child: const Center(
              child: Text(
                  'No bookmarks added',
                  style: TextStyle(color: Colors.grey, fontSize: 20.0),
              ),
            ),
          )
          : listViewBuilder(),
    );
  }
  // /Container(child :Center(child: Text("no thing here"),))

  listViewBuilder() {
    return ListView.builder(
        itemBuilder: (context, index) {
          ListTrack.Track track = ListTrack.Track(
              trackId: int.parse(trackIdList![index]),
              trackName: trackNameList[index],
              albumName : trackAlbumList[index],
              artistName : trackAlbumList[index],
          );

          return TrackTile(
            track: track,
          );
        },
        itemCount: trackIdList?.length);
  }
}