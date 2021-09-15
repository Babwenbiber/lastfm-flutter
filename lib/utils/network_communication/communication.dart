import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lastfm/utils/constants.dart';
import 'package:lastfm/utils/error/exceptions.dart';

class Communication {
  static const String BASE_URL = "ws.audioscrobbler.com";
  static const String SUB_URL = "/2.0/";

  static Map<String, dynamic> addSessionParametersOfRequest(
      Map<String, dynamic> args, String method) {
    args.putIfAbsent("api_key", () => LAST_FM_API_KEY);
    args.putIfAbsent("method", () => method);
    args.putIfAbsent("format", () => "json");

    return args;
  }

  static dynamic returnRequest200(response) {
    Map<String, dynamic> body = json.decode(response.body);
    if (!body.containsKey("error")) {
      debugPrint("returning good data $body");
      return body;
    } else {
      debugPrint("error ${body["error"]}");
      throw ServerException(body["error"]);
    }
  }

  static dynamic returnRequestNot200(response) {
    throw ServerUnknownStatusException();
  }

  static Uri getUriFromArgs(Map<String, dynamic> args, String method) {
    args = addSessionParametersOfRequest(args, method);
    return Uri.http(BASE_URL, SUB_URL, args);
  }

  static Future<dynamic> sendGetRequestForFuture(
      http.Client client, Map<String, dynamic> args, String method) async {
    final response = await client
        .get(
      getUriFromArgs(args, method),
    )
        .timeout(Duration(seconds: 30), onTimeout: () {
      throw ServerTimeoutException();
    });
    debugPrint("network: response: ${response.body}");
    return returnResponse(response);
  }

  static dynamic returnResponse(http.Response response) {
    if (response.statusCode == 200) {
      return returnRequest200(response);
    } else {
      return returnRequestNot200(response);
    }
  }
}
