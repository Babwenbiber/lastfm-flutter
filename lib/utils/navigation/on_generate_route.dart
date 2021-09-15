import 'package:flutter/material.dart';
import 'package:lastfm/presentation/pages/album_details_page.dart';
import 'package:lastfm/presentation/pages/artist_top_albums_page.dart';
import 'package:lastfm/presentation/pages/home_page.dart';
import 'package:lastfm/presentation/pages/search_artist_page.dart';
import 'package:lastfm/utils/navigation/arguments/album_details_page_args.dart';

import 'arguments/artist_top_albums_page_args.dart';

Route<dynamic>? onGenerateRoute(RouteSettings? settings, BuildContext context) {
  switch (settings?.name) {
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return HomePage();
        },
      );
    case SearchArtistPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return SearchArtistPage();
        },
      );
    case ArtistTopAlbumsPage.routeName:
      final ArtistTopAlbumsPageArgs args =
          settings?.arguments as ArtistTopAlbumsPageArgs;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return ArtistTopAlbumsPage(
            artistName: args.artistName,
          );
        },
      );
    case AlbumDetailsPage.routeName:
      final AlbumDetailsPageArgs args =
          settings?.arguments as AlbumDetailsPageArgs;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return AlbumDetailsPage(
            artistName: args.artistName,
            albumName: args.albumName,
          );
        },
      );
  }
}
