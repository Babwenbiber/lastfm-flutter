import 'dart:convert';

import 'package:bloc_test/bloc_test.dart' as bt;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lastfm/models/artists_details.dart';
import 'package:lastfm/models/responses/artist_search_response.dart';
import 'package:lastfm/presentation/bloc/search_artist/search_artist_bloc.dart';
import 'package:lastfm/repositories/lastfm_repository.dart';
import 'package:lastfm/utils/error/failures.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'search_artist_bloc_test.mocks.dart';

@GenerateMocks([LastfmRepository])
void main() {
  final MockLastfmRepository repository = MockLastfmRepository();
  final ArtistsDetails artists = ArtistSearchResponse.fromJson(
          json.decode(fixture("responses/artist_search.json")))
      .artists;
  final String artistName = "asd";
  final Failure failure = ServerFailure("bla");

  group("test search artist bloc", () {
    bt.blocTest("should have no states on no events",
        build: () {
          return SearchArtistBloc(lastfmRepository: repository);
        },
        expect: () => []);
    bt.blocTest(
        "should have loading and complete state on search events success",
        build: () {
          when(repository.searchArtists(artistName))
              .thenAnswer((_) async => Right(artists));
          return SearchArtistBloc(lastfmRepository: repository);
        },
        act: (SearchArtistBloc bloc) =>
            bloc.add(SearchArtistEventSearch(artistName)),
        expect: () => [SearchArtistLoading(), SearchArtistComplete(artists)]);
    bt.blocTest("should have loading and error state on search events failure",
        build: () {
          when(repository.searchArtists(artistName))
              .thenAnswer((_) async => Left(failure));
          return SearchArtistBloc(lastfmRepository: repository);
        },
        act: (SearchArtistBloc bloc) =>
            bloc.add(SearchArtistEventSearch(artistName)),
        expect: () => [SearchArtistLoading(), SearchArtistError(failure.msg)]);
  });
}
