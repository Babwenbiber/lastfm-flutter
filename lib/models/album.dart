import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/models/artist.dart';
import 'package:lastfm/models/lastfm_image.dart';

part 'album.g.dart';

@JsonSerializable(explicitToJson: true)
class Album extends Equatable {
  final String name;
  final String url;
  final Artist artist;
  final int playcount;
  @JsonKey(name: "image")
  final List<LastfmImage> images;

  Album(
      {required this.playcount,
      required this.name,
      required this.artist,
      required this.images,
      required this.url});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  factory Album.fromAlbumDetails(AlbumDetails album) => Album(
        name: album.name,
        url: album.url,
        artist: Artist(name: album.artistName, url: ""),
        images: album.images,
        playcount: int.parse(album.playCount),
      );

  @override
  List<Object?> get props => [playcount, name, artist, images, url];
}
