import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/presentation/bloc/home/home_bloc.dart';
import 'package:lastfm/presentation/bloc/search_artist/search_artist_bloc.dart';
import 'package:lastfm/presentation/widgets/album_preview_widget.dart';
import 'package:lastfm/presentation/widgets/last_fm_app_bar.dart';
import 'package:lastfm/presentation/widgets/white_text.dart';
import 'package:lastfm/utils/injection/injection_container.dart';
import 'package:lastfm/utils/language/home_page_text.dart';
import 'package:lastfm/utils/navigation/navigation.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "home_page";
  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) => sl<HomeBloc>(), child: _HomePageWithProvider());
}

class _HomePageWithProvider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePageWithProvider> {
  late HomeBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<HomeBloc>(context);
    _bloc.add(HomeEventGetAlbums());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: LastFmAppBar(
          backButton: false,
          title: HomePageText.title,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _bloc.add(HomeEventGetAlbums());
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [getSearchBar(), getDownloadedContent()],
              ),
            ),
          ),
        ),
      );

  Widget getSearchBar() {
    return GestureDetector(
      onTap: () => Navigation.navigateToSearchArtistPage(context),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                "search artist",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDownloadedContent() {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
      if (state is HomeLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is HomeError) {
        return Center(child: WhiteText(state.msg));
      } else if (state is HomeComplete) {
        return getAlbumListView(state.albums);
      } else {
        return Container();
      }
    });
  }

  Widget getAlbumListView(Albums albums) {
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
