import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:lastfm/utils/constants.dart';
import 'package:lastfm/utils/error/exceptions.dart';
import 'package:lastfm/utils/network_communication/api_routes.dart';
import 'package:lastfm/utils/network_communication/communication.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/fixture_reader.dart';
import 'communication_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  late MockClient client = MockClient();
  group("test communication util functions -> addSessionParametersOfRequest",
      () {
    test("should add args when no args present", () {
      Map<String, dynamic> args = {};
      String myKey = "myArg";
      String myValue = "myVal";
      String methodName = "myMethod";
      args[myKey] = myValue;
      args = Communication.addSessionParametersOfRequest(args, methodName);
      expect(args[myKey], myValue);
      expect(args["method"], methodName);
      expect(args["api_key"], LAST_FM_API_KEY);
      expect(args["format"], "json");
    });
  });

  group("test communication util functions -> sendGetRequestForFuture", () {
    final Uri uri =
        Communication.getUriFromArgs({}, ApiRoutes.GET_ALBUM_DETAILS);
    test("should return dynamic value on status code 200 and no error",
        () async {
      when(client.get(uri, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              Response(fixture("responses/album_getinfo.json"), 200));
      dynamic res = await Communication.sendGetRequestForFuture(
          client, {}, ApiRoutes.GET_ALBUM_DETAILS);
      expect(res, isNot(equals(null)));
    });

    test("should throw Exception on error", () async {
      when(client.get(uri, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              Response(fixture("responses/error.json"), 200));

      expect(
          () async => await Communication.sendGetRequestForFuture(
              client, {}, ApiRoutes.GET_ALBUM_DETAILS),
          throwsA(ServerException(10)));
    });
  });
}
