import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/presentation/bloc/artist_top_albums/artist_top_albums_bloc.dart';
import 'package:lastfm/presentation/widgets/album_preview_widget.dart';
import 'package:lastfm/presentation/widgets/last_fm_app_bar.dart';
import 'package:lastfm/presentation/widgets/loading_overlay.dart';
import 'package:lastfm/presentation/widgets/white_text.dart';
import 'package:lastfm/utils/injection/injection_container.dart';
import 'package:lastfm/utils/language/artist_top_albums_page_text.dart';

class ArtistTopAlbumsPage extends StatelessWidget {
  static const String routeName = "artist_top_albums_page";
  final String artistName;

  const ArtistTopAlbumsPage({Key? key, required this.artistName})
      : super(key: key);
  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) => sl<ArtistTopAlbumsBloc>(),
      child: _ArtistTopAlbumsPageWithProvider(artistName: artistName));
}

class _ArtistTopAlbumsPageWithProvider extends StatefulWidget {
  final String artistName;

  const _ArtistTopAlbumsPageWithProvider({Key? key, required this.artistName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArtistTopAlbumsPageState();
}

class _ArtistTopAlbumsPageState
    extends State<_ArtistTopAlbumsPageWithProvider> {
  late ArtistTopAlbumsBloc _bloc;
  final LoadingOverlay _loadingOverlay = LoadingOverlay();

  @override
  void initState() {
    _bloc = BlocProvider.of<ArtistTopAlbumsBloc>(context);
    _bloc.add(ArtistTopAlbumsEventGet(widget.artistName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LastFmAppBar(
        title: widget.artistName,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(child: WhiteText(SearchArtistPageText.topAlbumText)),
            getResults()
          ],
        ),
      ),
    );
  }

  Widget getBlocListener({required Widget child}) {
    return BlocListener<ArtistTopAlbumsBloc, ArtistTopAlbumsState>(
      listener: (BuildContext context, ArtistTopAlbumsState state) {
        if (state is ArtistTopAlbumsLoading) {
          _loadingOverlay.show(context);
        } else {
          _loadingOverlay.hide();
        }
      },
      child: child,
    );
  }

  Widget getResults() {
    return BlocBuilder<ArtistTopAlbumsBloc, ArtistTopAlbumsState>(
        builder: (BuildContext context, ArtistTopAlbumsState state) {
      if (state is ArtistTopAlbumsError) {
        return Center(child: WhiteText(state.msg));
      } else if (state is ArtistTopAlbumsComplete) {
        return getTopAlbums(state.albums);
      } else {
        return Container();
      }
    });
  }

  Widget getTopAlbums(Albums albums) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return AlbumPreviewWidget(album: albums.albums[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: albums.albums.length);
  }
}
