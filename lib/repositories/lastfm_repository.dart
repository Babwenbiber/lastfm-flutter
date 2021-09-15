import 'package:dartz/dartz.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/models/albums.dart';
import 'package:lastfm/models/artists_details.dart';
import 'package:lastfm/utils/error/failures.dart';

abstract class LastfmRepository {
  Future<Either<Failure, AlbumDetails>> getAlbumDetails(
      String artistName, String albumName);
  Future<Either<Failure, ArtistsDetails>> searchArtists(String artistName);
  Future<Either<Failure, Albums>> getTopAlbumsOfArtist(String artistName);
}
