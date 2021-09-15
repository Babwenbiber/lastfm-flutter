// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lastfm_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastfmImage _$LastfmImageFromJson(Map<String, dynamic> json) {
  return LastfmImage(
    size: json['size'] as String,
    url: json['#text'] as String,
  );
}

Map<String, dynamic> _$LastfmImageToJson(LastfmImage instance) =>
    <String, dynamic>{
      'size': instance.size,
      '#text': instance.url,
    };
