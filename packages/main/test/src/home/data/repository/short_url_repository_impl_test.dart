import 'package:core/core.dart'
    show ApiEngineer, UriFactory, LocalStorage, Failure;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:main/src/home/data/repository/short_url_repository_impl.dart'
    show ShortUrlRepositoryImpl;
import 'package:main/src/home/domain/entity/alias_entity.dart';
import 'package:main/src/utils/constants.dart' show Constants;
import 'package:mocktail/mocktail.dart' show Mock, any, verify, when;

class _MockApiEngineer extends Mock implements ApiEngineer {}

class _MockUriFactory extends Mock implements UriFactory {}

class _MockResponse extends Mock implements Response {}

class _MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late ApiEngineer apiEngineer;
  late UriFactory uriFactory;
  late LocalStorage _localStorage;
  late ShortUrlRepositoryImpl repository;

  setUp(() {
    apiEngineer = _MockApiEngineer();
    uriFactory = _MockUriFactory();
    _localStorage = _MockLocalStorage();
    repository = ShortUrlRepositoryImpl(apiEngineer, uriFactory, _localStorage);
  });

  test('should return alias entity when call use case', () async {
    final response = _MockResponse();
    final uri = Uri();

    when(
      () => uriFactory.create(Constants.baseUrl, "/api/alias"),
    ).thenReturn(uri);
    when(() => response.body).thenReturn(
      '{"alias": "google.com", "_links":{"self":"google.com","short":"google"}}',
    );
    when(
      () => apiEngineer.postSafeRequest(uri, null, {"url": "google.com"}),
    ).thenAnswer((_) async => response);

    final result = await repository.shortUrl("google.com");
    expect(result.isRight(), true);

    final alias = result.getOrElse(() => throw Exception());
    expect(alias.alias, "google.com");
    expect(alias.links.short, "google");
    expect(alias.links.self, "google.com");

    verify(() => uriFactory.create(any(), "/api/alias")).called(1);
    verify(() => response.body).called(1);
    verify(
      () => apiEngineer.postSafeRequest(uri, null, {"url": "google.com"}),
    ).called(1);
  });

  test('returns failure when API call throws an exception', () async {
    final uri = Uri();

    when(
      () => uriFactory.create(Constants.baseUrl, "/api/alias"),
    ).thenReturn(uri);
    when(
      () => apiEngineer.postSafeRequest(uri, null, {"url": "google.com"}),
    ).thenThrow(Exception("API error"));

    final result = await repository.shortUrl("google.com");
    expect(result.isLeft(), true);

    final failure = result.fold((l) => l, (r) => null);
    expect(failure, isA<Failure>());

    verify(() => uriFactory.create(any(), "/api/alias")).called(1);
    verify(
      () => apiEngineer.postSafeRequest(uri, null, {"url": "google.com"}),
    ).called(1);
  });

  test('returns empty list when no aliases are saved', () async {
    when(
      () => _localStorage.getString(Constants.db),
    ).thenAnswer((_) async => null);

    final aliases = await repository.getAliases();
    expect(aliases, isEmpty);

    verify(() => _localStorage.getString(Constants.db)).called(1);
  });

  test('saves alias successfully', () async {
    final alias = AliasEntity(
      "google.com",
      LinksEntity("google.com", "google"),
    );
    final aliasesJson =
        '[{"alias":"google.com","_links":{"self":"google.com","short":"google"}}]';

    when(
      () => _localStorage.getString(Constants.db),
    ).thenAnswer((_) async => null);
    when(
      () => _localStorage.saveString(Constants.db, aliasesJson),
    ).thenAnswer((_) async => true);

    final result = await repository.saveAlias(alias);
    expect(result, true);

    verify(() => _localStorage.getString(Constants.db)).called(1);
    verify(() => _localStorage.saveString(Constants.db, aliasesJson)).called(1);
  });

  test('should remove an alias successfully', () async {
    final alias = AliasEntity(
      "google.com",
      LinksEntity("google.com", "google"),
    );
    final aliasesJson =
        '[{"alias":"google.com","_links":{"self":"google.com","short":"google"}}]';

    when(
      () => _localStorage.getString(Constants.db),
    ).thenAnswer((_) async => aliasesJson);
    when(
      () => _localStorage.saveString(Constants.db, '[]'),
    ).thenAnswer((_) async => true);

    await repository.removeAlias(alias);

    verify(() => _localStorage.getString(Constants.db)).called(2);
    verify(() => _localStorage.saveString(Constants.db, '[]')).called(1);
  });

  test('should does not remove alias if it does not exist', () async {
    final alias = AliasEntity(
      "google.com",
      LinksEntity("google.com", "google"),
    );
    final aliasesJson =
        '[{"alias":"abc.com","_links":{"self":"google.com","short":"google"}}]';

    when(
      () => _localStorage.getString(Constants.db),
    ).thenAnswer((_) async => aliasesJson);

    final updatedAliases = await repository.removeAlias(alias);
    expect(updatedAliases.length, 1);
    expect(updatedAliases.first.alias, "abc.com");

    verify(() => _localStorage.getString(Constants.db)).called(1);
  });
}
