import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastfm/models/artists_details.dart';
import 'package:lastfm/presentation/bloc/search_artist/search_artist_bloc.dart';
import 'package:lastfm/presentation/widgets/artist_widget.dart';
import 'package:lastfm/presentation/widgets/last_fm_app_bar.dart';
import 'package:lastfm/presentation/widgets/loading_overlay.dart';
import 'package:lastfm/utils/injection/injection_container.dart';
import 'package:lastfm/utils/language/search_artist_page_text.dart';

class SearchArtistPage extends StatelessWidget {
  static const String routeName = "search_artist_page";
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => sl<SearchArtistBloc>(),
        child: _SearchArtistPageWithProvider(),
      );
}

class _SearchArtistPageWithProvider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchArtistPageState();
}

class _SearchArtistPageState extends State<_SearchArtistPageWithProvider> {
  final LoadingOverlay _loadingOverlay = LoadingOverlay();
  late SearchArtistBloc _bloc;
  final FocusNode _textfieldFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _bloc = BlocProvider.of<SearchArtistBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _textfieldFocusNode.unfocus(),
        child: Scaffold(
          appBar: LastFmAppBar(
            title: SearchArtistPageText.title,
          ),
          body: getBody(),
        ),
      );

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            getSearchBar(),
            getSubmitButton(),
            getSearchResults(),
          ],
        ),
      ),
    );
  }

  Widget getSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: TextField(
          controller: _textEditingController,
          focusNode: _textfieldFocusNode,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            border: InputBorder.none,
            hintText: SearchArtistPageText.searchHint,
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget getSubmitButton() {
    return GestureDetector(
      onTap: () =>
          _bloc.add(SearchArtistEventSearch(_textEditingController.value.text)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.blue),
          child: Center(
            child: Text(
              SearchArtistPageText.enterButtonText,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchResults() {
    return BlocBuilder<SearchArtistBloc, SearchArtistState>(
        builder: (BuildContext context, SearchArtistState state) {
      if (state is SearchArtistError) {
        return Center(
          child: Text(
            state.msg,
            style: TextStyle(color: Colors.white),
          ),
        );
      } else if (state is SearchArtistLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SearchArtistComplete) {
        return getArtistListView(state.artists);
      } else {
        return Container();
      }
    });
  }

  Widget getArtistListView(ArtistsDetails artists) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ArtistWidget(artist: artists.artists[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: artists.artists.length);
  }
}
