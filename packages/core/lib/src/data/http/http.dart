import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' as response;
import 'package:injectable/injectable.dart';

@injectable
class Http {
  Future<response.Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) async =>
      await http.get(
        url,
        headers: headers,
      );

  Future<response.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async =>
      await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
        encoding: encoding,
      );

  Future<response.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async =>
      await http.delete(
        url,
        headers: headers,
        body: jsonEncode(body),
        encoding: encoding,
      );
}
