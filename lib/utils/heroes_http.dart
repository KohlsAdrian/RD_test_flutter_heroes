import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:rd_test_flutter_heroes/utils/heroes_enums.dart';

class HeroesHttp {
  HeroesHttp._();
  static HeroesHttp instance = HeroesHttp._();

  Future<void> request(
    String url, {
    HeroesRequestType requestType = HeroesRequestType.get,
    void Function(dynamic result)? onSuccess,
    void Function(dynamic result)? onFail,
  }) async {
    final uri = Uri.parse(url);
    dynamic result;
    switch (requestType) {
      case HeroesRequestType.get:
        result = await _get(uri);
        break;
    }

    if (onSuccess != null) {
      onSuccess(result);
    } else if (onFail != null) {
      onFail(result);
    }
  }
}

dynamic _get(Uri uri) async {
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    try {
      final bodyBytes = response.bodyBytes;
      final jsonString = convert.utf8.decode(bodyBytes);
      final json = convert.json.decode(jsonString);
      return json;
    } catch (e) {
      return response;
    }
  }
  return response;
}
