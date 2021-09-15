import 'dart:convert';

import 'package:bloc_test/bloc_test.dart' as bt;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/models/responses/artist_topalbums_response.dart';
import 'package:lastfm/presentation/bloc/home/home_bloc.dart';
import 'package:lastfm/repositories/offline_repository.dart';
import 'package:lastfm/utils/error/failures.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([OfflineRepository])
void main() {
  final MockOfflineRepository repository = MockOfflineRepository();
  final Albums albums = ArtistTopalbumsResponse.fromJson(
          json.decode(fixture("responses/artist_topalbums.json")))
      .albums;
  final String artistName = "asd";
  final Failure failure = ServerFailure("bla");

  group("test home bloc", () {
    bt.blocTest("should have no states on no events",
        build: () {
          return HomeBloc(offlineRepository: repository);
        },
        expect: () => []);
    bt.blocTest("should have loading and complete state on get events success",
        build: () {
          when(repository.getAlbumsLocally())
              .thenAnswer((_) async => Right(albums));
          return HomeBloc(offlineRepository: repository);
        },
        act: (HomeBloc bloc) => bloc.add(HomeEventGetAlbums()),
        expect: () => [HomeLoading(), HomeComplete(albums)]);
    bt.blocTest("should have loading and error state on get events failure",
        build: () {
          when(repository.getAlbumsLocally())
              .thenAnswer((_) async => Left(failure));
          return HomeBloc(offlineRepository: repository);
        },
        act: (HomeBloc bloc) => bloc.add(HomeEventGetAlbums()),
        expect: () => [HomeLoading(), HomeError(failure.msg)]);
  });
}
