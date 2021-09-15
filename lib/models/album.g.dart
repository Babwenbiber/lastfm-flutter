// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return Album(
    playcount: json['playcount'] as int,
    name: json['name'] as String,
    artist: Artist.fromJson(json['artist'] as Map<String, dynamic>),
    images: (json['image'] as List<dynamic>)
        .map((e) => LastfmImage.fromJson(e as Map<String, dynamic>))
        .toList(),
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'artist': instance.artist.toJson(),
      'playcount': instance.playcount,
      'image': instance.images.map((e) => e.toJson()).toList(),
    };
