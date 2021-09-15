import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/models/lastfm_image.dart';
import 'package:lastfm/models/tracks.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  final AlbumDetails albumDetails = AlbumDetails(
      listeners: "501560",
      playCount: "3536257",
      tracks: Tracks.fromJson({
        "track": [
          {
            "artist": {
              "url": "https:\/\/www.last.fm\/music\/Cher",
              "name": "Cher",
            },
            "duration": 236,
            "url": "https:\/\/www.last.fm\/music\/Cher\/Believe\/Believe",
            "name": "Believe"
          }
        ]
      }),
      images: [
        LastfmImage.fromJson({
          "size": "small",
          "#text":
              "https:\/\/lastfm.freetls.fastly.net\/i\/u\/34s\/3b54885952161aaea4ce2965b2db1638.png"
        })
      ],
      url: "https:\/\/www.last.fm\/music\/Cher\/Believe",
      artistName: "Cher",
      name: "Believe",
      mbId: "03c91c40-49a6-44a7-90e7-a700edf97a62");
  final Map<String, dynamic> map =
      json.decode(fixture("models/album_details.json"));
  group("test album details parsing", () {
    test("should have a model after from json call", () {
      final res = AlbumDetails.fromJson(map);
      expect(res, albumDetails);
    });
    test("should have original map after from json to jsoncall", () {
      final res = AlbumDetails.fromJson(map).toJson();
      expect(res, map);
    });
  });
}
