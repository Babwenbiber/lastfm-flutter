import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lastfm/models/artist.dart';
import 'package:lastfm/models/track.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  final Track track = Track(
      artist: Artist.fromJson({
        "url": "https:\/\/www.last.fm\/music\/Cher",
        "name": "Cher",
      }),
      duration: 236,
      url: "https:\/\/www.last.fm\/music\/Cher\/Believe\/Believe",
      name: "Believe");
  final Map<String, dynamic> map = json.decode(fixture("models/track.json"));
  group("test album details parsing", () {
    test("should have a model after from json call", () {
      final res = Track.fromJson(map);
      expect(res, track);
    });
    test("should have original map after from json to jsoncall", () {
      final res = Track.fromJson(map).toJson();
      expect(res, map);
    });
  });
}
