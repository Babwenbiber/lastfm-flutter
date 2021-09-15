// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tracks _$TracksFromJson(Map<String, dynamic> json) {
  return Tracks(
    tracks: _trackFromJson(json['track']),
  );
}

Map<String, dynamic> _$TracksToJson(Tracks instance) => <String, dynamic>{
      'track': instance.tracks.map((e) => e.toJson()).toList(),
    };
