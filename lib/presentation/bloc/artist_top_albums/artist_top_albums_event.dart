part of 'artist_top_albums_bloc.dart';

abstract class ArtistTopAlbumsEvent extends Equatable {
  const ArtistTopAlbumsEvent();
}

class ArtistTopAlbumsEventGet extends ArtistTopAlbumsEvent {
  final String artistName;
  const ArtistTopAlbumsEventGet(this.artistName);

  @override
  List<Object?> get props => [artistName];
}
