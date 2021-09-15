import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lastfm/models/artist.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  final Artist artist = Artist(
    url: "https:\/\/www.last.fm\/music\/Cher",
    name: "Cher",
  );
  final Map<String, dynamic> map = json.decode(fixture("models/artist.json"));
  group("test artist parsing", () {
    test("should have a model after from json call", () {
      final res = Artist.fromJson(map);
      expect(res, artist);
    });
    test("should have original map after from json to jsoncall", () {
      final res = Artist.fromJson(map).toJson();
      expect(res, map);
    });
  });
}
