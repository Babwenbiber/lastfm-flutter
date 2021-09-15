import 'package:equatable/equatable.dart';
import 'package:lastfm/models/albums.dart';

class ArtistTopalbumsResponse extends Equatable {
  final Albums albums;

  ArtistTopalbumsResponse({required this.albums});
  factory ArtistTopalbumsResponse.fromJson(Map<String, dynamic> json) =>
      ArtistTopalbumsResponse(albums: Albums.fromJson(json["topalbums"]));

  Map<String, dynamic> toJson() => {"topalbums": albums.toJson()};
  @override
  List<Object?> get props => [albums];
}
