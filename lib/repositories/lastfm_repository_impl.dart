import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/models/artists_details.dart';
import 'package:lastfm/models/responses/album_getinfo_response.dart';
import 'package:lastfm/models/responses/artist_search_response.dart';
import 'package:lastfm/models/responses/artist_topalbums_response.dart';
import 'package:lastfm/repositories/lastfm_repository.dart';
import 'package:lastfm/utils/error/exceptions.dart';
import 'package:lastfm/utils/error/failures.dart';
import 'package:lastfm/utils/network_communication/api_routes.dart';
import 'package:lastfm/utils/network_communication/communication.dart';

class LastfmRepositoryImpl extends LastfmRepository {
  final Client client;

  LastfmRepositoryImpl(this.client);
  @override
  Future<Either<Failure, AlbumDetails>> getAlbumDetails(
      String artistName, String albumName) async {
    try {
      final Map<String, dynamic> args = {
        "artist": artistName,
        "album": albumName,
      };
      return Right(AlbumGetinfoResponse.fromJson(
              (await (Communication.sendGetRequestForFuture(
                  client, args, ApiRoutes.GET_ALBUM_DETAILS))))
          .album);
    } on Exception catch (e) {
      return Left(getFailureFromException(e));
    } catch (e) {
      return Left(getFailureFromException(UnknownException()));
    }
  }

  @override
  Future<Either<Failure, ArtistsDetails>> searchArtists(
      String artistName) async {
    try {
      final Map<String, dynamic> args = {
        "artist": artistName,
      };
      return Right(ArtistSearchResponse.fromJson(
              (await (Communication.sendGetRequestForFuture(
                  client, args, ApiRoutes.SEARCH_ARTIST))))
          .artists);
    } on Exception catch (e) {
      return Left(getFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, Albums>> getTopAlbumsOfArtist(
      String artistName) async {
    try {
      final Map<String, dynamic> args = {
        "artist": artistName,
      };
      return Right(ArtistTopalbumsResponse.fromJson(
              (await (Communication.sendGetRequestForFuture(
                  client, args, ApiRoutes.GET_ARTISTS_TOP_ALBUMS))))
          .albums);
    } on Exception catch (e) {
      return Left(getFailureFromException(e));
    }
  }
}
