import 'package:flutter/foundation.dart';
import 'package:lastfm/models/album.dart';
import 'package:lastfm/models/albums.dart';

class LocalAlbums extends ChangeNotifier {
static final LocalAlbums _instance = LocalAlbums._internal();
  Albums albums = Albums(albums: []);
bool init = false;

  factory LocalAlbums() {
    return _instance;
  }

  void refreshAlbum( Albums _albums) {
    if (_albums == albums && init == true)
      return;
    init = true;
    albums = _albums;
    notifyListeners();
  }

  void removeAlbum(Album album) {
    albums.albums.remove(album);
    notifyListeners();
  }

  void addAlbum(Album album) {
    albums.albums.add(album);
    notifyListeners();
  }

  LocalAlbums._internal();
}