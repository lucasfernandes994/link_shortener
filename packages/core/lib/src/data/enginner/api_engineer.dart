import 'package:http/http.dart';

abstract class ApiEngineer {
  Future<Response> getSafeRequest(
    Uri uri,
    Map<String, String>? queryParameters,
  );

  Future<Response> postSafeRequest(
    Uri uri,
    Map<String, String>? queryParameters,
    Object? body,
  );

  Future<Response> deleteSafeRequest(
    Uri uri,
    Object? body,
  );
}
