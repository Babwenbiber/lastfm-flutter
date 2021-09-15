// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumDetails _$AlbumDetailsFromJson(Map<String, dynamic> json) {
  return AlbumDetails(
    name: json['name'] as String,
    artistName: json['artist'] as String,
    mbId: json['mbid'] as String,
    images: (json['image'] as List<dynamic>)
        .map((e) => LastfmImage.fromJson(e as Map<String, dynamic>))
        .toList(),
    listeners: json['listeners'] as String,
    playCount: json['playcount'] as String,
    tracks: json['tracks'] == null
        ? null
        : Tracks.fromJson(json['tracks'] as Map<String, dynamic>),
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$AlbumDetailsToJson(AlbumDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'artist': instance.artistName,
      'mbid': instance.mbId,
      'image': instance.images.map((e) => e.toJson()).toList(),
      'listeners': instance.listeners,
      'playcount': instance.playCount,
      'tracks': instance.tracks?.toJson(),
      'url': instance.url,
    };
