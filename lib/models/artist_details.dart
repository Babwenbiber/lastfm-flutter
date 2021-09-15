import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lastfm/models/lastfm_image.dart';

part 'artist_details.g.dart';

@JsonSerializable(explicitToJson: true)
class ArtistDetails extends Equatable {
  final String name;
  final String mbid;
  final String url;
  final String listeners;
  @JsonKey(name: "image")
  final List<LastfmImage> images;

  ArtistDetails(
      {required this.name,
      required this.mbid,
      required this.url,
      required this.listeners,
      required this.images});

  factory ArtistDetails.fromJson(Map<String, dynamic> json) =>
      _$ArtistDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistDetailsToJson(this);

  @override
  List<Object?> get props => [name, mbid, url, listeners, images];
}
