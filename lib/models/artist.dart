import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable(explicitToJson: true)
class Artist extends Equatable {
  final String name;
  final String url;

  Artist({required this.name, required this.url});

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);

  @override
  List<Object?> get props => [name, url];
}
