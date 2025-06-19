import 'package:core/core.dart' show ApiEngineer, UriFactory;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:main/src/home/data/repository/short_url_repository_impl.dart'
    show ShortUrlRepositoryImpl;
import 'package:mocktail/mocktail.dart' show Mock, any, verify, when;

class _MockApiEngineer extends Mock implements ApiEngineer {}

class _MockUriFactory extends Mock implements UriFactory {}

class _MockResponse extends Mock implements Response {}

void main() {
  late ApiEngineer apiEngineer;
  late UriFactory uriFactory;
  late ShortUrlRepositoryImpl repository;

  setUp(() {
    apiEngineer = _MockApiEngineer();
    uriFactory = _MockUriFactory();
    repository = ShortUrlRepositoryImpl(apiEngineer, uriFactory);
  });

  test('should return alias entity when call use case', () async {
    final response = _MockResponse();
    final uri = Uri();

    when(
      () => uriFactory.create(
        "https://url-shortener-nu.herokuapp.com",
        "/api/alias",
      ),
    ).thenReturn(uri);
    when(
      () => response.body,
    ).thenReturn('{"alias": "google.com", "links": []}');
    when(
      () => apiEngineer.postSafeRequest(uri, null, any()),
    ).thenAnswer((_) async => response);

    final result = await repository.shortUrl("google.com");
    expect(result.isRight(), true);

    final alias = result.getOrElse(() => throw Exception());
    expect(alias.alias, "google.com");
    expect(alias.links, []);
    verify(
      () => uriFactory.create(
        "https://url-shortener-nu.herokuapp.com",
        "/api/alias",
      ),
    ).called(1);
    verify(() => response.body).called(1);
    verify(() => apiEngineer.postSafeRequest(uri, null, any())).called(1);
  });
}
