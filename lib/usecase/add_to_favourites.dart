import 'package:dartz/dartz.dart';
import 'package:lastfm/models/album.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/presentation/bloc/home/home_bloc.dart';
import 'package:lastfm/repositories/offline_repository.dart';
import 'package:lastfm/usecase/usecase.dart';
import 'package:lastfm/utils/error/failures.dart';
import 'package:lastfm/utils/injection/injection_container.dart';
import 'package:lastfm/utils/local_albums/local_albums.dart';

class AddToFavorites extends UseCase<AddToFavoritesArgs, bool>{
  final OfflineRepository offlineRepository;

  AddToFavorites({required this.offlineRepository});

  @override
  Future<Either<Failure, bool>> call(AddToFavoritesArgs args) {
    final res = offlineRepository.saveAlbumLocally(args.album);
    LocalAlbums().addAlbum(Album.fromAlbumDetails(args.album));
    return res;
  }

}

class AddToFavoritesArgs extends UseCaseArgs {
  final AlbumDetails album;

   AddToFavoritesArgs(this.album);
}