// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artists_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistsDetails _$ArtistsDetailsFromJson(Map<String, dynamic> json) {
  return ArtistsDetails(
    artists: (json['artist'] as List<dynamic>)
        .map((e) => ArtistDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ArtistsDetailsToJson(ArtistsDetails instance) =>
    <String, dynamic>{
      'artist': instance.artists.map((e) => e.toJson()).toList(),
    };
