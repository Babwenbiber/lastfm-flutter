part of 'artist_top_albums_bloc.dart';

abstract class ArtistTopAlbumsState extends Equatable {
  const ArtistTopAlbumsState();
  @override
  List<Object> get props => [];
}

class ArtistTopAlbumsInitial extends ArtistTopAlbumsState {}

class ArtistTopAlbumsLoading extends ArtistTopAlbumsState {}

class ArtistTopAlbumsError extends ArtistTopAlbumsState {
  final String msg;

  ArtistTopAlbumsError(this.msg);
  @override
  List<Object> get props => [msg];
}

class ArtistTopAlbumsComplete extends ArtistTopAlbumsState {
  final Albums albums;

  ArtistTopAlbumsComplete(this.albums);
  @override
  List<Object> get props => [albums];
}
