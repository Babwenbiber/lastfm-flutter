import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lastfm/models/artist_details.dart';
import 'package:lastfm/models/lastfm_image.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  final ArtistDetails artist = ArtistDetails(
      name: "Cher",
      listeners: "1303691",
      mbid: "bfcc6d75-a6a5-4bc6-8282-47aec8531818",
      url: "https://www.last.fm/music/Cher",
      images: [
        LastfmImage.fromJson({
          "#text":
              "https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png",
          "size": "small"
        })
      ]);
  final Map<String, dynamic> map =
      json.decode(fixture("models/artist_details.json"));
  group("test artist parsing", () {
    test("should have a model after from json call", () {
      final res = ArtistDetails.fromJson(map);
      expect(res, artist);
    });
    test("should have original map after from json to jsoncall", () {
      final res = ArtistDetails.fromJson(map).toJson();
      expect(res, map);
    });
  });
}
