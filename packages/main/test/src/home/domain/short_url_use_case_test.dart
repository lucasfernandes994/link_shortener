import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart' show AliasEntity;
import 'package:main/src/home/domain/repository/short_url_repository.dart';
import 'package:main/src/home/domain/use_case/short_url_use_case.dart'
    show ShortUrlUseCase;
import 'package:mocktail/mocktail.dart';

class _MockShortUrlRepository extends Mock implements ShortUrlRepository {}

void main() {
  late ShortUrlRepository repository;
  late ShortUrlUseCase useCase;

  setUp(() {
    repository = _MockShortUrlRepository();
    useCase = ShortUrlUseCase(repository);
  });

  test('should return alias entity when call use case', () async {
    final alias = AliasEntity("", []);
    //  Given
    when(
      () => repository.shortUrl("google.com"),
    ).thenAnswer((_) async => Right(alias));
    //  When
    final result = await useCase.call("google.com");
    //  Then
    expect(result, Right(alias));
    verify(() => repository.shortUrl("google.com")).called(1);
  });

  test('should return failure when url is empty', () async {
    final result = await useCase.call("");
    expect(result, isA<Left>());
  });
}
