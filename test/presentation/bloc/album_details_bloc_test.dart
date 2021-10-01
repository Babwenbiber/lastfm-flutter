import 'dart:convert';

import 'package:bloc_test/bloc_test.dart' as bt;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lastfm/models/album.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/models/responses/album_getinfo_response.dart';
import 'package:lastfm/presentation/bloc/album_details/album_details_bloc.dart';
import 'package:lastfm/repositories/lastfm_repository.dart';
import 'package:lastfm/repositories/offline_repository.dart';
import 'package:lastfm/usecase/add_to_favourites.dart';
import 'package:lastfm/usecase/remove_from_favourites.dart';
import 'package:lastfm/utils/error/failures.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/fixture_reader.dart';
import 'album_details_bloc_test.mocks.dart';

@GenerateMocks([LastfmRepository, OfflineRepository, AddToFavorites, RemoveFromFavorites])
void main() {
  final MockLastfmRepository lastfmRepository = MockLastfmRepository();
  final MockOfflineRepository offlineRepository = MockOfflineRepository();
    final MockAddToFavorites addToFavorites = MockAddToFavorites();
  final MockRemoveFromFavorites removeFromFavorites = MockRemoveFromFavorites();
  final AlbumDetails album = AlbumGetinfoResponse.fromJson(
          json.decode(fixture("responses/album_getinfo.json")))
      .album;
  final String artistName = "asd";
  final String albumName = "asdas";
  final Failure failure = ServerFailure("bla");
  late SharedPreferences prefs;

  group("test album details bloc", () {
    bt.blocTest("should have no states on no events",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          prefs = await SharedPreferences.getInstance();
        },
        build: () {
          return AlbumDetailsBloc(
              lastfmRepository: lastfmRepository,
              offlineRepository: offlineRepository,
              preferences: prefs, addToFavourites: addToFavorites, removeFromFavorites: removeFromFavorites);
        },
        expect: () => []);
    bt.blocTest("should have loading and complete state on get events success",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          prefs = await SharedPreferences.getInstance();
        },
        build: () {
          when(lastfmRepository.getAlbumDetails(artistName, albumName))
              .thenAnswer((_) async => Right(album));

            return AlbumDetailsBloc(
              lastfmRepository: lastfmRepository,
              offlineRepository: offlineRepository,
              preferences: prefs, addToFavourites: addToFavorites, removeFromFavorites: removeFromFavorites);
        },
        act: (AlbumDetailsBloc bloc) =>
            bloc.add(AlbumDetailsEventGet(artistName, albumName)),
        expect: () =>
            [AlbumDetailsLoading(), AlbumDetailsComplete(album, false)]);
    bt.blocTest("should have loading and error state on get events failure",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          prefs = await SharedPreferences.getInstance();
        },
        build: () {
          when(lastfmRepository.getAlbumDetails(artistName, albumName))
              .thenAnswer((_) async => Left(failure));

            return AlbumDetailsBloc(
              lastfmRepository: lastfmRepository,
              offlineRepository: offlineRepository,
              preferences: prefs, addToFavourites: addToFavorites, removeFromFavorites: removeFromFavorites);
        },
        act: (AlbumDetailsBloc bloc) =>
            bloc.add(AlbumDetailsEventGet(artistName, albumName)),
        expect: () => [AlbumDetailsLoading(), AlbumDetailsError(failure.msg)]);
    bt.blocTest(
        "OFFLINE should have loading and complete state on get events success",
        setUp: () async {
          SharedPreferences.setMockInitialValues({
            "albums": [json.encode(album.toJson())]
          });
          prefs = await SharedPreferences.getInstance();
        },
        build: () {
          when(offlineRepository.getAlbumLocally(album.artistName, album.name))
              .thenAnswer((_) async => Right(album));

              return AlbumDetailsBloc(
              lastfmRepository: lastfmRepository,
              offlineRepository: offlineRepository,
              preferences: prefs, addToFavourites: addToFavorites, removeFromFavorites: removeFromFavorites);
        },
        act: (AlbumDetailsBloc bloc) =>
            bloc.add(AlbumDetailsEventGet(album.artistName, album.name)),
        expect: () =>
            [AlbumDetailsLoading(), AlbumDetailsComplete(album, true)]);
    bt.blocTest(
        "OFFLINE should have loading and error state on get events failure",
        setUp: () async {
          SharedPreferences.setMockInitialValues({
            "albums": [json.encode(album.toJson())]
          });
          prefs = await SharedPreferences.getInstance();
        },
        build: () {
          when(offlineRepository.getAlbumLocally(artistName, albumName))
              .thenAnswer((_) async => Left(failure));

              return AlbumDetailsBloc(
              lastfmRepository: lastfmRepository,
              offlineRepository: offlineRepository,
              preferences: prefs, addToFavourites: addToFavorites, removeFromFavorites: removeFromFavorites);
        },
        act: (AlbumDetailsBloc bloc) =>
            bloc.add(AlbumDetailsEventGet(artistName, albumName)),
        expect: () => [AlbumDetailsLoading(), AlbumDetailsError(failure.msg)]);

    bt.blocTest("should have no states on save event success",
        build: () {
          when(addToFavorites(AddToFavoritesArgs(album)))
              .thenAnswer((_) async => Right(true));
          return AlbumDetailsBloc(
              lastfmRepository: lastfmRepository,
              offlineRepository: offlineRepository,
              preferences: prefs, addToFavourites: addToFavorites, removeFromFavorites: removeFromFavorites);
        },
        act: (AlbumDetailsBloc bloc) => bloc.add(AlbumDetailsEventSave(album)),
        expect: () => []);
    bt.blocTest("should have error state on remove event failure",
        build: () {
          when(addToFavorites(AddToFavoritesArgs(album)))
              .thenAnswer((_) async => Left(failure));
          return AlbumDetailsBloc(
              lastfmRepository: lastfmRepository,
              offlineRepository: offlineRepository,
              preferences: prefs, addToFavourites: addToFavorites, removeFromFavorites: removeFromFavorites);
        },
        act: (AlbumDetailsBloc bloc) => bloc.add(AlbumDetailsEventSave(album)),
        expect: () => [AlbumDetailsError(failure.msg)]);

    bt.blocTest("should have no states on remove event success",
        build: () {
          when(removeFromFavorites(RemoveFromFavoritesArgs(album)))
              .thenAnswer((_) async => Right(true));
             return AlbumDetailsBloc(
              lastfmRepository: lastfmRepository,
              offlineRepository: offlineRepository,
              preferences: prefs, addToFavourites: addToFavorites, removeFromFavorites: removeFromFavorites);
        },
        act: (AlbumDetailsBloc bloc) =>
            bloc.add(AlbumDetailsEventRemove(album)),
        expect: () => []);
    bt.blocTest("should have error state on remove event failure",
        build: () {
          when(removeFromFavorites(RemoveFromFavoritesArgs(album)))
              .thenAnswer((_) async => Left(failure));
              return AlbumDetailsBloc(
              lastfmRepository: lastfmRepository,
              offlineRepository: offlineRepository,
              preferences: prefs, addToFavourites: addToFavorites, removeFromFavorites: removeFromFavorites);
        },
        act: (AlbumDetailsBloc bloc) =>
            bloc.add(AlbumDetailsEventRemove(album)),
        expect: () => [AlbumDetailsError(failure.msg)]);
  });
}
