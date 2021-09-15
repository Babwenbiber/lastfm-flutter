part of 'album_details_bloc.dart';

abstract class AlbumDetailsEvent extends Equatable {
  const AlbumDetailsEvent();
}

class AlbumDetailsEventGet extends AlbumDetailsEvent {
  final String artistName;
  final String albumName;

  AlbumDetailsEventGet(this.artistName, this.albumName);

  @override
  List<Object?> get props => [artistName, albumName];
}

class AlbumDetailsEventSave extends AlbumDetailsEvent {
  final AlbumDetails album;

  AlbumDetailsEventSave(this.album);

  @override
  List<Object?> get props => [album];
}

class AlbumDetailsEventRemove extends AlbumDetailsEvent {
  final AlbumDetails album;

  AlbumDetailsEventRemove(this.album);

  @override
  List<Object?> get props => [album];
}
