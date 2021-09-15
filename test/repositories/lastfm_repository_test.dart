import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/models/artists_details.dart';
import 'package:lastfm/models/responses/artist_search_response.dart';
import 'package:lastfm/models/responses/artist_topalbums_response.dart';
import 'package:lastfm/repositories/lastfm_repository.dart';
import 'package:lastfm/repositories/lastfm_repository_impl.dart';
import 'package:lastfm/utils/error/exceptions.dart';
import 'package:lastfm/utils/error/failures.dart';
import 'package:lastfm/utils/network_communication/api_routes.dart';
import 'package:lastfm/utils/network_communication/communication.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/fixture_reader.dart';
import '../utils/handle_either_test_result.dart';
import 'lastfm_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late LastfmRepository repository;
  late MockClient mockHttpClient;
  final AlbumDetails albumDetails = AlbumDetails.fromJson(
      json.decode(fixture("responses/album_getinfo.json"))["album"]);
  final ArtistsDetails artists = ArtistSearchResponse.fromJson(
          json.decode(fixture("responses/artist_search.json")))
      .artists;
  final Albums albums = ArtistTopalbumsResponse.fromJson(
          json.decode(fixture("responses/artist_topalbums.json")))
      .albums;
  final String albumName = "myalbum";
  final String artistName = "foo";
  final Failure failure = getFailureFromException(ServerException(10));
  final Map<String, dynamic> getAlbumArgs = {
    "artist": artistName,
    "album": albumName,
  };
  final Map<String, dynamic> searchArtistArgs = {
    "artist": artistName,
  };
  final Map<String, dynamic> topAlbumArgs = {
    "artist": artistName,
  };
  setUp(() {
    mockHttpClient = MockClient();
    repository = LastfmRepositoryImpl(mockHttpClient);
  });

  group("test lastfm repository ->get album details", () {
    final Uri uri =
        Communication.getUriFromArgs(getAlbumArgs, ApiRoutes.GET_ALBUM_DETAILS);
    test("should perform GET request with URL + GET_ALBUM_DETAILS", () async {
      when(mockHttpClient.get(
        uri,
        headers: anyNamed('headers'),
      )).thenAnswer((realInvocation) async =>
          http.Response(fixture("responses/album_getinfo.json"), 200));
      print("uri is $uri");

      await repository.getAlbumDetails(artistName, albumName);
      verify(mockHttpClient.get(
        uri,
        headers: anyNamed('headers'),
      ));
    });

    test("should perform GET to get album and return a album", () async {
      when(mockHttpClient.get(uri, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              http.Response(fixture("responses/album_getinfo.json"), 200));

      final result = await repository.getAlbumDetails(artistName, albumName);

      expectRight(result, albumDetails);
    });

    test("should perform GET to get album and return a failure on error code",
        () async {
      when(mockHttpClient.get(uri, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              http.Response(fixture("responses/error.json"), 200));

      final result = await repository.getAlbumDetails(artistName, albumName);

      expectLeft(result, failure);
    });
  });

  group("test lastfm repository ->search artist", () {
    final Uri uri =
        Communication.getUriFromArgs(searchArtistArgs, ApiRoutes.SEARCH_ARTIST);
    test("should perform GET request with URL + SEARCH_ARTIST", () async {
      when(mockHttpClient.get(
        uri,
        headers: anyNamed('headers'),
      )).thenAnswer((realInvocation) async =>
          http.Response(fixture("responses/artist_search.json"), 200));
      print("uri is $uri");

      await repository.searchArtists(artistName);
      verify(mockHttpClient.get(
        uri,
        headers: anyNamed('headers'),
      ));
    });

    test("should perform GET to artist_search and return artists", () async {
      when(mockHttpClient.get(uri, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              http.Response(fixture("responses/artist_search.json"), 200));

      final result = await repository.searchArtists(artistName);

      expectRight(result, artists);
    });

    test("should perform GET to get album and return a failure on error code",
        () async {
      when(mockHttpClient.get(uri, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              http.Response(fixture("responses/error.json"), 200));

      final result = await repository.searchArtists(artistName);

      expectLeft(result, failure);
    });
  });
  group("test lastfm repository ->get top albums", () {
    final Uri uri = Communication.getUriFromArgs(
        topAlbumArgs, ApiRoutes.GET_ARTISTS_TOP_ALBUMS);
    test("should perform GET request with URL + GET_ARTISTS_TOP_ALBUMS",
        () async {
      when(mockHttpClient.get(
        uri,
        headers: anyNamed('headers'),
      )).thenAnswer((realInvocation) async =>
          http.Response(fixture("responses/artist_topalbums.json"), 200));
      print("uri is $uri");

      await repository.getTopAlbumsOfArtist(artistName);
      verify(mockHttpClient.get(
        uri,
        headers: anyNamed('headers'),
      ));
    });

    test("should perform GET to get top albums and return albums", () async {
      when(mockHttpClient.get(uri, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              http.Response(fixture("responses/artist_topalbums.json"), 200));

      final result = await repository.getTopAlbumsOfArtist(artistName);

      expectRight(result, albums);
    });

    test(
        "should perform GET to get top albums and return a failure on error code",
        () async {
      when(mockHttpClient.get(uri, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              http.Response(fixture("responses/error.json"), 200));

      final result = await repository.getTopAlbumsOfArtist(artistName);

      expectLeft(result, failure);
    });
  });
}
