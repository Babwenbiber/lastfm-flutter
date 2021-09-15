import 'package:dartz/dartz.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/utils/error/failures.dart';

abstract class OfflineRepository {
  Future<Either<Failure, bool>> saveAlbumLocally(AlbumDetails album);
  Future<Either<Failure, bool>> removeAlbumLocally(AlbumDetails album);
  Future<Either<Failure, Albums>> getAlbumsLocally();
  Future<Either<Failure, AlbumDetails?>> getAlbumLocally(
      String artistName, String albumName);
}
