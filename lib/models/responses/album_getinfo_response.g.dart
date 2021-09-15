// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_getinfo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumGetinfoResponse _$AlbumGetinfoResponseFromJson(Map<String, dynamic> json) {
  return AlbumGetinfoResponse(
    album: AlbumDetails.fromJson(json['album'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AlbumGetinfoResponseToJson(
        AlbumGetinfoResponse instance) =>
    <String, dynamic>{
      'album': instance.album.toJson(),
    };
