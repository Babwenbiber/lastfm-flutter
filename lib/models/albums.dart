import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lastfm/models/album.dart';
import 'package:lastfm/models/album_details.dart';

part 'albums.g.dart';

@JsonSerializable(explicitToJson: true)
class Albums extends Equatable {
  @JsonKey(name: "album")
  final List<Album> albums;

  Albums({required this.albums});

  factory Albums.fromJson(Map<String, dynamic> json) => _$AlbumsFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumsToJson(this);

  factory Albums.fromAlbumDetailsList(List<AlbumDetails> albums) =>
      Albums(albums: albums.map((a) => Album.fromAlbumDetails(a)).toList());

  @override
  List<Object?> get props => [albums];
}
