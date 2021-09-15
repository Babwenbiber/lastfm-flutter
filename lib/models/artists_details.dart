import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'artist_details.dart';

part 'artists_details.g.dart';

@JsonSerializable(explicitToJson: true)
class ArtistsDetails extends Equatable {
  @JsonKey(name: "artist")
  final List<ArtistDetails> artists;

  ArtistsDetails({required this.artists});

  factory ArtistsDetails.fromJson(Map<String, dynamic> json) =>
      _$ArtistsDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistsDetailsToJson(this);

  @override
  List<Object?> get props => [artists];
}
