import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lastfm_image.g.dart';

@JsonSerializable(explicitToJson: true)
class LastfmImage extends Equatable {
  final String size;
  @JsonKey(name: "#text")
  final String url;

  LastfmImage({required this.size, required this.url});
  factory LastfmImage.fromJson(Map<String, dynamic> json) =>
      _$LastfmImageFromJson(json);

  Map<String, dynamic> toJson() => _$LastfmImageToJson(this);
  @override
  List<Object?> get props => [size, url];
}
