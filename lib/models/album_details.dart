import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lastfm/models/lastfm_image.dart';
import 'package:lastfm/models/tracks.dart';

part 'album_details.g.dart';

@JsonSerializable(explicitToJson: true)
class AlbumDetails extends Equatable {
  final String name;
  @JsonKey(name: "artist")
  final String artistName;
  @JsonKey(name: "mbid")
  final String mbId;
  @JsonKey(name: "image")
  final List<LastfmImage> images;
  final String listeners;
  @JsonKey(name: "playcount")
  final String playCount;
  final Tracks? tracks;
  final String url;

  AlbumDetails(
      {required this.name,
      required this.artistName,
      required this.mbId,
      required this.images,
      required this.listeners,
      required this.playCount,
      required this.tracks,
      required this.url});

  factory AlbumDetails.fromJson(Map<String, dynamic> json) =>
      _$AlbumDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumDetailsToJson(this);

  @override
  List<Object?> get props =>
      [name, artistName, mbId, images, listeners, playCount, tracks, url];
}
