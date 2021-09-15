import 'package:equatable/equatable.dart';
import 'package:lastfm/models/artists_details.dart';

class ArtistSearchResponse extends Equatable {
  final ArtistsDetails artists;

  ArtistSearchResponse({required this.artists});
  factory ArtistSearchResponse.fromJson(Map<String, dynamic> json) =>
      ArtistSearchResponse(
          artists: ArtistsDetails.fromJson(json["results"]["artistmatches"]));

  Map<String, dynamic> toJson() => {
        "results": {"artistmatches": artists.toJson()}
      };
  @override
  List<Object?> get props => [artists];
}
