import 'package:dartz/dartz.dart';
import 'package:lastfm/models/album.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/repositories/offline_repository.dart';
import 'package:lastfm/usecase/usecase.dart';
import 'package:lastfm/utils/error/failures.dart';
import 'package:lastfm/utils/local_albums/local_albums.dart';

class RemoveFromFavorites extends UseCase<RemoveFromFavoritesArgs, bool>{
  final OfflineRepository offlineRepository;

  RemoveFromFavorites({required this.offlineRepository});

  @override
  Future<Either<Failure, bool>> call(RemoveFromFavoritesArgs args) {
    final res = offlineRepository.removeAlbumLocally(args.album);
        LocalAlbums().removeAlbum(Album.fromAlbumDetails(args.album));
        return res;

  }

}

class RemoveFromFavoritesArgs extends UseCaseArgs {
  final AlbumDetails album;

   RemoveFromFavoritesArgs(this.album);

  @override
  List<Object?> get props => [album];
}