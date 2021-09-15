import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/presentation/bloc/album_details/album_details_bloc.dart';
import 'package:lastfm/presentation/widgets/last_fm_app_bar.dart';
import 'package:lastfm/presentation/widgets/white_text.dart';
import 'package:lastfm/utils/injection/injection_container.dart';
import 'package:lastfm/utils/language/album_details_page_text.dart';

class AlbumDetailsPage extends StatelessWidget {
  static const String routeName = "album_details_page";
  final String artistName;
  final String albumName;

  const AlbumDetailsPage(
      {Key? key, required this.artistName, required this.albumName})
      : super(key: key);
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => sl<AlbumDetailsBloc>(),
        child: _AlbumDetailsPageWithProvider(
          artistName: artistName,
          albumName: albumName,
        ),
      );
}

class _AlbumDetailsPageWithProvider extends StatefulWidget {
  final String artistName;
  final String albumName;
  const _AlbumDetailsPageWithProvider(
      {Key? key, required this.artistName, required this.albumName})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _AlbumDetailsPageState();
}

class _AlbumDetailsPageState extends State<_AlbumDetailsPageWithProvider> {
  late AlbumDetailsBloc _bloc;
  bool _albumIsSaved = false;
  AlbumDetails? _album;

  @override
  void initState() {
    _bloc = BlocProvider.of<AlbumDetailsBloc>(context);
    _bloc.add(AlbumDetailsEventGet(widget.artistName, widget.albumName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LastFmAppBar(
        title: widget.albumName,
        actionWidget: getSaveButton(),
      ),
      body: getBody(),
    );
  }

  Widget getSaveButton() {
    return GestureDetector(
        onTap: () {
          if (_album != null) {
            if (_albumIsSaved) {
              _bloc.add(AlbumDetailsEventRemove(_album!));
            } else {
              _bloc.add(AlbumDetailsEventSave(_album!));
            }
            setState(() {
              _albumIsSaved = !_albumIsSaved;
            });
          }
        },
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.save,
              color: _albumIsSaved ? Colors.green : Colors.white,
            )));
  }

  Widget getBody() {
    return getBlocListener(
      child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(8.0), child: getContent()),
      ),
    );
  }

  Widget getBlocListener({required Widget child}) {
    return BlocListener<AlbumDetailsBloc, AlbumDetailsState>(
        listener: (BuildContext context, AlbumDetailsState state) {
          if (state is AlbumDetailsComplete) {
            _album = state.albumDetails;
            setState(() {
              _albumIsSaved = state.downloaded;
            });
          }
        },
        child: child);
  }

  Widget getContent() {
    return BlocBuilder<AlbumDetailsBloc, AlbumDetailsState>(
        builder: (BuildContext context, AlbumDetailsState state) {
      if (state is AlbumDetailsLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is AlbumDetailsComplete) {
        return Column(
          children: [
            getMetaDataOfAlbum(state.albumDetails),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: WhiteText(
                AlbumDetailsPageText.tracks,
                fontSize: 18,
              ),
            ),
            getTracks(state.albumDetails)
          ],
        );
      } else if (state is AlbumDetailsError) {
        return Center(child: WhiteText(state.msg));
      } else {
        return Container();
      }
    });
  }

  Widget getMetaDataOfAlbum(AlbumDetails album) {
    return Column(
      children: [
        LimitedBox(
            maxHeight: 250,
            child: album.images.last.url.isNotEmpty
                ? CachedNetworkImage(imageUrl: album.images.last.url)
                : Container()),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(child: WhiteText(AlbumDetailsPageText.albumName)),
            Expanded(child: WhiteText(album.name))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(child: WhiteText(AlbumDetailsPageText.artistName)),
            Expanded(child: WhiteText(album.artistName))
          ],
        )
      ],
    );
  }

  Widget getTracks(AlbumDetails album) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return WhiteText(album.tracks!.tracks[index].name);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: album.tracks?.tracks.length ?? 0);
  }
}
