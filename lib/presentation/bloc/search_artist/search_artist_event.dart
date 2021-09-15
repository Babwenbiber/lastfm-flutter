part of 'search_artist_bloc.dart';

abstract class SearchArtistEvent extends Equatable {
  const SearchArtistEvent();
}

class SearchArtistEventSearch extends SearchArtistEvent {
  final String artistName;

  SearchArtistEventSearch(this.artistName);

  @override
  List<Object?> get props => [artistName];
}
