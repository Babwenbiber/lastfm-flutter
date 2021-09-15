import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lastfm/models/artists_details.dart';
import 'package:lastfm/repositories/lastfm_repository.dart';
import 'package:lastfm/utils/error/failures.dart';

part 'search_artist_event.dart';
part 'search_artist_state.dart';

class SearchArtistBloc extends Bloc<SearchArtistEvent, SearchArtistState> {
  final LastfmRepository lastfmRepository;
  SearchArtistBloc({required this.lastfmRepository})
      : super(SearchArtistInitial());

  @override
  Stream<SearchArtistState> mapEventToState(
    SearchArtistEvent event,
  ) async* {
    if (event is SearchArtistEventSearch) {
      yield* mapSearchEventToState(event);
    }
  }

  Stream<SearchArtistState> mapSearchEventToState(
    SearchArtistEventSearch event,
  ) async* {
    yield SearchArtistLoading();
    final res = await lastfmRepository.searchArtists(event.artistName);
    yield* res.fold((Failure failure) async* {
      yield SearchArtistError(failure.msg);
    }, (ArtistsDetails artists) async* {
      yield SearchArtistComplete(artists);
    });
  }
}
