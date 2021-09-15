// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
    name: json['name'] as String,
    duration: json['duration'] as int,
    url: json['url'] as String,
    artist: Artist.fromJson(json['artist'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'name': instance.name,
      'duration': instance.duration,
      'url': instance.url,
      'artist': instance.artist.toJson(),
    };
