import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lastfm/models/lastfm_image.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  final LastfmImage albumImage = LastfmImage(
      size: "small",
      url:
          "https:\/\/lastfm.freetls.fastly.net\/i\/u\/34s\/3b54885952161aaea4ce2965b2db1638.png");
  final Map<String, dynamic> mapAlbumImage =
      json.decode(fixture("models/album_image.json"));
  group("test album details parsing", () {
    test("should have a model after from json call", () {
      final res = LastfmImage.fromJson(mapAlbumImage);
      expect(res, albumImage);
    });
    test("should have original map after from json  to jsoncall", () {
      final res = LastfmImage.fromJson(mapAlbumImage).toJson();
      expect(res, mapAlbumImage);
    });
  });
}
