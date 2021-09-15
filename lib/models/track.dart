import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lastfm/models/artist.dart';

part 'track.g.dart';

@JsonSerializable(explicitToJson: true)
class Track extends Equatable {
  final String name;
  final int duration;
  final String url;
  final Artist artist;

  Track(
      {required this.name,
      required this.duration,
      required this.url,
      required this.artist});

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Map<String, dynamic> toJson() => _$TrackToJson(this);

  @override
  List<Object?> get props => [name, duration, url, artist];
}
