import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lastfm/models/album.dart';
import 'package:lastfm/models/artist.dart';
import 'package:lastfm/models/lastfm_image.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  final Album album = Album(
    name: "Chronicles",
    playcount: 24309,
    url: "https://www.last.fm/music/Cher/Chronicles",
    artist: Artist.fromJson(
        {"name": "Cher", "url": "https://www.last.fm/music/Cher"}),
    images: [
      LastfmImage.fromJson({
        "#text":
            "https://lastfm.freetls.fastly.net/i/u/34s/8919a1d5af0449859556c9adeed956fe.png",
        "size": "small"
      })
    ],
  );
  final Map<String, dynamic> map = json.decode(fixture("models/album.json"));
  group("test album details parsing", () {
    test("should have a model after from json call", () {
      final res = Album.fromJson(map);
      expect(res, album);
    });
    test("should have original map after from json to jsoncall", () {
      final res = Album.fromJson(map).toJson();
      expect(res, map);
    });
  });
}
