import 'package:core/src/data/http/http.dart';
import 'package:core/src/utils/exception.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'api_engineer.dart';

@Injectable(as: ApiEngineer)
class ApiEngineerImpl extends ApiEngineer {
  final Http http;
  final Logger logger;

  static Map<String, String> headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  ApiEngineerImpl(this.http, this.logger);

  @override
  Future<Response> getSafeRequest(
    Uri uri,
    Map<String, String>? queryParameters,
  ) async {
    _logRequest(method: 'GET', uri: uri, headers: headers);

    final response = await http.get(uri, headers: headers);

    _logResponse(method: 'GET', uri: uri, response: response);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<Response> postSafeRequest(
    Uri uri,
    Map<String, String>? queryParameters,
    Object? body,
  ) async {
    _logRequest(method: 'POST', uri: uri, headers: headers, body: body);

    final response = await http.post(uri, headers: headers, body: body);

    _logResponse(method: 'POST', uri: uri, response: response);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response;
    } else {
      throw HttpException(response.body);
    }
  }

  @override
  Future<Response> deleteSafeRequest(Uri uri, Object? body) async {
    _logRequest(method: 'DELETE', uri: uri, headers: headers);

    final response = await http.delete(uri, headers: headers, body: body);

    _logResponse(method: 'DELETE', uri: uri, response: response);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response;
    } else {
      throw HttpException(response.body);
    }
  }

  void _logRequest({
    required String method,
    required Uri uri,
    required Map<String, String> headers,
    Object? body = null,
  }) {
    logger.d('REQUEST');
    logger.d('METHOD $method');
    logger.d(uri);
    logger.i(headers);
    if (body != null) logger.i(body);
  }

  void _logResponse({
    required String method,
    required Uri uri,
    required Response response,
  }) {
    logger.d('RESPONSE: ');
    logger.d('METHOD $method');
    logger.d(uri);
    logger.i(response.statusCode.toString());
    logger.i(response.body);
  }
}
