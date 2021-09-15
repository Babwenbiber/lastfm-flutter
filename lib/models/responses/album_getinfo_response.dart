import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lastfm/models/album_details.dart';

part 'album_getinfo_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AlbumGetinfoResponse extends Equatable {
  final AlbumDetails album;

  AlbumGetinfoResponse({required this.album});
  factory AlbumGetinfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AlbumGetinfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumGetinfoResponseToJson(this);
  @override
  List<Object?> get props => [album];
}
