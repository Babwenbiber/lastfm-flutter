import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastfm/models/artist_details.dart';
import 'package:lastfm/presentation/widgets/white_text.dart';
import 'package:lastfm/utils/navigation/navigation.dart';

class ArtistWidget extends StatelessWidget {
  final ArtistDetails artist;

  const ArtistWidget({Key? key, required this.artist}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigation.navigateToArtistTopAlbumsPage(context, artist.name),
      child: Row(
        children: [getImage(), getText()],
      ),
    );
  }

  Widget getImage() {
    if (artist.images[0].url.isEmpty) {
      return Container(
        height: 30,
        width: 30,
      );
    }

    return Container(
        height: 30, width: 30, child: Image.network(artist.images[0].url));
  }

  Widget getText() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: LimitedBox(maxWidth: 250, child: WhiteText(artist.name)),
    );
  }
}
