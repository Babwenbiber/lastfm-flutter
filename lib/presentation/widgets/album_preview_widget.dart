import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:lastfm/models/album.dart';
import 'package:lastfm/presentation/widgets/white_text.dart';
import 'package:lastfm/utils/navigation/navigation.dart';

class AlbumPreviewWidget extends StatelessWidget {
  final Album album;

  const AlbumPreviewWidget({Key? key, required this.album}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigation.navigateToAlbumDetailsPage(
          context, album.artist.name, album.name),
      child: Row(
        children: [getImage(), getText()],
      ),
    );
  }

  Widget getImage() {
    if (album.images[0].url.isEmpty) {
      return Container(
        height: 30,
        width: 30,
      );
    }
    return Container(
      height: 30,
      width: 30,
      child: CachedNetworkImage(
        imageUrl: album.images[0].url,
      ),
    );
  }

  Widget getText() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: LimitedBox(maxWidth: 250, child: WhiteText(album.name)),
    );
  }
}
