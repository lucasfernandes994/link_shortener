import 'package:core/src/data/enginner/api_engineer_impl.dart' show ApiEngineerImpl;
import 'package:core/src/data/http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as response;
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockHttp extends Mock implements Http {}

class MockLogger extends Mock implements Logger {}

void main() {
  late Http http;
  late Logger logger;
  late ApiEngineerImpl apiEngineerImpl;

  setUp(() {
    http = MockHttp();
    logger = MockLogger();
    apiEngineerImpl = ApiEngineerImpl(http, logger);
  });

  test('should execute getSafeRequest', () async {
    final Uri uri = Uri();
    final result = response.Response('', 200);

    when(() => http.get(uri, headers: ApiEngineerImpl.headers))
        .thenAnswer((invocation) async => result);
    when(() => logger.d('REQUEST')).thenAnswer((invocation) {});
    when(() => logger.d('METHOD GET')).thenAnswer((invocation) {});
    when(() => logger.d(uri)).thenAnswer((invocation) {});
    when(() => logger.d(ApiEngineerImpl.headers)).thenAnswer((invocation) {});
    when(() => logger.d(result.statusCode.toString()))
        .thenAnswer((invocation) {});
    when(() => logger.d(result.body)).thenAnswer((invocation) {});

    await apiEngineerImpl.getSafeRequest(uri, null);
  });

  test('should execute postSafeRequest', () async {
    final Uri uri = Uri();
    final result = response.Response('', 200);
    final String body = "";

    when(() => http.post(uri, headers: ApiEngineerImpl.headers, body: body))
        .thenAnswer((invocation) async => result);
    when(() => logger.d('REQUEST')).thenAnswer((invocation) {});
    when(() => logger.d('METHOD POST')).thenAnswer((invocation) {});
    when(() => logger.d(uri)).thenAnswer((invocation) {});
    when(() => logger.d(ApiEngineerImpl.headers)).thenAnswer((invocation) {});
    when(() => logger.d(result.statusCode.toString()))
        .thenAnswer((invocation) {});
    when(() => logger.d(result.body)).thenAnswer((invocation) {});

    await apiEngineerImpl.postSafeRequest(uri, null, body);
  });

  test('should execute deleteSafeRequest', () async {
    final Uri uri = Uri();
    final result = response.Response('', 200);
    final String body = "";

    when(() => http.delete(uri, headers: ApiEngineerImpl.headers, body: body))
        .thenAnswer((invocation) async => result);
    when(() => logger.d('REQUEST')).thenAnswer((invocation) {});
    when(() => logger.d('METHOD DELETE')).thenAnswer((invocation) {});
    when(() => logger.d(uri)).thenAnswer((invocation) {});
    when(() => logger.d(ApiEngineerImpl.headers)).thenAnswer((invocation) {});
    when(() => logger.d(result.statusCode.toString()))
        .thenAnswer((invocation) {});
    when(() => logger.d(result.body)).thenAnswer((invocation) {});

    await apiEngineerImpl.deleteSafeRequest(uri, body);
  });
}
