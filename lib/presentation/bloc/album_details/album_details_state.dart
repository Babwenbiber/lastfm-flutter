part of 'album_details_bloc.dart';

abstract class AlbumDetailsState extends Equatable {
  const AlbumDetailsState();
  @override
  List<Object> get props => [];
}

class AlbumDetailsInitial extends AlbumDetailsState {}

class AlbumDetailsLoading extends AlbumDetailsState {}

class AlbumDetailsError extends AlbumDetailsState {
  final String msg;

  AlbumDetailsError(this.msg);
  @override
  List<Object> get props => [msg];
}

class AlbumDetailsComplete extends AlbumDetailsState {
  final AlbumDetails albumDetails;
  final bool downloaded;

  AlbumDetailsComplete(this.albumDetails, this.downloaded);
  @override
  List<Object> get props => [albumDetails, downloaded];
}
