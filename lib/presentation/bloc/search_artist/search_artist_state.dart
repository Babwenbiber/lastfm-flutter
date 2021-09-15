part of 'search_artist_bloc.dart';

abstract class SearchArtistState extends Equatable {
  const SearchArtistState();
  @override
  List<Object> get props => [];
}

class SearchArtistInitial extends SearchArtistState {}

class SearchArtistLoading extends SearchArtistState {}

class SearchArtistError extends SearchArtistState {
  final String msg;

  SearchArtistError(this.msg);
  @override
  List<Object> get props => [msg];
}

class SearchArtistComplete extends SearchArtistState {
  final ArtistsDetails artists;

  SearchArtistComplete(this.artists);
  @override
  List<Object> get props => [artists];
}
