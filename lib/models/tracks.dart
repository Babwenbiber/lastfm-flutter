import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lastfm/models/track.dart';

part 'tracks.g.dart';

@JsonSerializable(explicitToJson: true)
class Tracks extends Equatable {
  @JsonKey(name: "track", nullable: false, fromJson: _trackFromJson)
  final List<Track> tracks;

  const Tracks({required this.tracks});

  factory Tracks.fromJson(Map<String, dynamic> json) => _$TracksFromJson(json);

  Map<String, dynamic> toJson() => _$TracksToJson(this);

  @override
  List<Object?> get props => [tracks];
}

List<Track> _trackFromJson(json) {
  if (json == null) {
    return [];
  } else if (json is List) {
    return json.map((e) => Track.fromJson(e as Map<String, dynamic>)).toList();
  } else if (json is Map<String, dynamic>) {
    return [Track.fromJson(json)];
  } else {
    return [];
  }
}
