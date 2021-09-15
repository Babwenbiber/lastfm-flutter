import 'dart:convert';

import 'package:bloc_test/bloc_test.dart' as bt;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/models/responses/artist_topalbums_response.dart';
import 'package:lastfm/presentation/bloc/artist_top_albums/artist_top_albums_bloc.dart';
import 'package:lastfm/repositories/lastfm_repository.dart';
import 'package:lastfm/utils/error/failures.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'search_artist_bloc_test.mocks.dart';

@GenerateMocks([LastfmRepository])
void main() {
  final MockLastfmRepository repository = MockLastfmRepository();
  final Albums albums = ArtistTopalbumsResponse.fromJson(
          json.decode(fixture("responses/artist_topalbums.json")))
      .albums;
  final String artistName = "asd";
  final Failure failure = ServerFailure("bla");

  group("test search artist bloc", () {
    bt.blocTest("should have no states on no events",
        build: () {
          return ArtistTopAlbumsBloc(lastfmRepository: repository);
        },
        expect: () => []);
    bt.blocTest("should have loading and complete state on get events success",
        build: () {
          when(repository.getTopAlbumsOfArtist(artistName))
              .thenAnswer((_) async => Right(albums));
          return ArtistTopAlbumsBloc(lastfmRepository: repository);
        },
        act: (ArtistTopAlbumsBloc bloc) =>
            bloc.add(ArtistTopAlbumsEventGet(artistName)),
        expect: () =>
            [ArtistTopAlbumsLoading(), ArtistTopAlbumsComplete(albums)]);
    bt.blocTest("should have loading and error state on get events failure",
        build: () {
          when(repository.getTopAlbumsOfArtist(artistName))
              .thenAnswer((_) async => Left(failure));
          return ArtistTopAlbumsBloc(lastfmRepository: repository);
        },
        act: (ArtistTopAlbumsBloc bloc) =>
            bloc.add(ArtistTopAlbumsEventGet(artistName)),
        expect: () =>
            [ArtistTopAlbumsLoading(), ArtistTopAlbumsError(failure.msg)]);
  });
}
