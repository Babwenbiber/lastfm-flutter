import 'package:flutter/material.dart';
import 'package:lastfm/presentation/pages/album_details_page.dart';
import 'package:lastfm/presentation/pages/artist_top_albums_page.dart';
import 'package:lastfm/presentation/pages/home_page.dart';
import 'package:lastfm/presentation/pages/search_artist_page.dart';
import 'package:lastfm/utils/navigation/arguments/album_details_page_args.dart';
import 'package:lastfm/utils/navigation/arguments/artist_top_albums_page_args.dart';

class Navigation {
  static navigateToHomePage(
    context,
  ) {
    Navigator.pushNamed(context, HomePage.routeName);
  }

  static navigateToSearchArtistPage(
    context,
  ) {
    Navigator.pushNamed(context, SearchArtistPage.routeName);
  }

  static navigateToArtistTopAlbumsPage(context, String artistName) {
    Navigator.pushNamed(context, ArtistTopAlbumsPage.routeName,
        arguments: ArtistTopAlbumsPageArgs(artistName: artistName));
  }

  static navigateToAlbumDetailsPage(
      context, String artistName, String albumName) {
    Navigator.pushNamed(context, AlbumDetailsPage.routeName,
        arguments:
            AlbumDetailsPageArgs(artistName: artistName, albumName: albumName));
  }
}
