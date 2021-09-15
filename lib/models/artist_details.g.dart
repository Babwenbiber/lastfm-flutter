// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistDetails _$ArtistDetailsFromJson(Map<String, dynamic> json) {
  return ArtistDetails(
    name: json['name'] as String,
    mbid: json['mbid'] as String,
    url: json['url'] as String,
    listeners: json['listeners'] as String,
    images: (json['image'] as List<dynamic>)
        .map((e) => LastfmImage.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ArtistDetailsToJson(ArtistDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mbid': instance.mbid,
      'url': instance.url,
      'listeners': instance.listeners,
      'image': instance.images.map((e) => e.toJson()).toList(),
    };
