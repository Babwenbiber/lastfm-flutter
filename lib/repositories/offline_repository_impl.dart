import 'package:dartz/dartz.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/repositories/offline_repository.dart';
import 'package:lastfm/utils/error/exceptions.dart';
import 'package:lastfm/utils/error/failures.dart';
import 'package:lastfm/utils/shared_preferences/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineRepositoryImpl extends OfflineRepository {
  final SharedPreferences preferences;

  OfflineRepositoryImpl(this.preferences);
  @override
  Future<Either<Failure, bool>> saveAlbumLocally(AlbumDetails album) async {
    try {
      final res = await saveAlbumToSharedPreferences(preferences, album);
      return Right(res);
    } catch (e) {
      return Left(getFailureFromException(UnknownException()));
    }
  }

  @override
  Future<Either<Failure, Albums>> getAlbumsLocally() async {
    try {
      final List<AlbumDetails> res =
          getAlbumsFromSharedPreferences(preferences);
      return Right(Albums.fromAlbumDetailsList(res));
    } catch (e) {
      return Left(getFailureFromException(UnknownException()));
    }
  }

  @override
  Future<Either<Failure, AlbumDetails?>> getAlbumLocally(
      String artistName, String albumName) async {
    try {
      final res = getAlbumFromNamesInSharedPreferences(
          preferences, artistName, albumName);
      return Right(res);
    } catch (e) {
      return Left(getFailureFromException(UnknownException()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeAlbumLocally(AlbumDetails album) async {
    try {
      final res = await removeAlbumToSharedPreferences(preferences, album);
      return Right(res);
    } catch (e) {
      return Left(getFailureFromException(UnknownException()));
    }
  }
}
