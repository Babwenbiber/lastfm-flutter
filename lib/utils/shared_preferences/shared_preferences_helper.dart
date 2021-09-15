import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/models/lastfm_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<AlbumDetails> getAlbumsFromSharedPreferences(
    SharedPreferences preferences) {
  final List<String>? res = preferences.getStringList(_albumKey);
  if (res == null) {
    return [];
  } else {
    return res.map((e) => AlbumDetails.fromJson(json.decode(e))).toList();
  }
}

AlbumDetails? getAlbumFromNamesInSharedPreferences(
    SharedPreferences preferences, String artistName, String albumName) {
  List<AlbumDetails> albums = getAlbumsFromSharedPreferences(preferences);
  for (AlbumDetails album in albums) {
    if (album.name == albumName && album.artistName == artistName) {
      return album;
    }
  }
}

Future<bool> saveAlbumToSharedPreferences(
    SharedPreferences preferences, AlbumDetails album) async {
  final Set<AlbumDetails> albums =
      getAlbumsFromSharedPreferences(preferences).toSet();
  albums.add(album);
  final List<String> albumStrings =
      albums.map((e) => json.encode(e.toJson())).toList();

  return (await preferences.setStringList(_albumKey, albumStrings));
}

Future<bool> removeAlbumToSharedPreferences(
    SharedPreferences preferences, AlbumDetails album) async {
  final List<AlbumDetails> albums =
      getAlbumsFromSharedPreferences(preferences).toList();
  albums.remove(album);
  final List<String> albumStrings =
      albums.map((e) => json.encode(e.toJson())).toList();

  return (await preferences.setStringList(_albumKey, albumStrings));
}

bool isAlbumContained(
    SharedPreferences preferences, String artistName, String albumName) {
  return getAlbumFromNamesInSharedPreferences(
          preferences, artistName, albumName) !=
      null;
}

const String _albumKey = "albums";
