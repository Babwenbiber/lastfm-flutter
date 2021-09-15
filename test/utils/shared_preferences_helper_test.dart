import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lastfm/models/album_details.dart';
import 'package:lastfm/models/responses/album_getinfo_response.dart';
import 'package:lastfm/utils/shared_preferences/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  late SharedPreferences preferences;
  final AlbumDetails album = AlbumGetinfoResponse.fromJson(
          json.decode(fixture("responses/album_getinfo.json")))
      .album;

  group("test shared preferences helper", () {
    test("should get empty list on get albums with empty preferences",
        () async {
      SharedPreferences.setMockInitialValues({});
      preferences = await SharedPreferences.getInstance();
      final res = getAlbumsFromSharedPreferences(preferences);
      expect(res, []);
    });

    test("should get list on get albums with filled preferences", () async {
      SharedPreferences.setMockInitialValues({
        "albums": [json.encode(album.toJson())]
      });
      preferences = await SharedPreferences.getInstance();
      final res = getAlbumsFromSharedPreferences(preferences);
      expect(res, [album]);
    });

    test(
        "should get album on get album with with existing albumName and artistName",
        () async {
      SharedPreferences.setMockInitialValues({
        "albums": [json.encode(album.toJson())]
      });
      preferences = await SharedPreferences.getInstance();
      final res = getAlbumFromNamesInSharedPreferences(
          preferences, album.artistName, album.name);
      expect(res, album);
    });
    //
    // test("should call set list strings on preferences on save album", () async {
    //   SharedPreferences.setMockInitialValues({});
    //   preferences = await SharedPreferences.getInstance();
    //   when(preferences.setStringList("albums", [json.encode(album.toJson())]))
    //       .thenAnswer((realInvocation) async => true);
    //   final res = saveAlbumToSharedPreferences(preferences, album);
    //   expect(res, true);
    // });
  });
}
