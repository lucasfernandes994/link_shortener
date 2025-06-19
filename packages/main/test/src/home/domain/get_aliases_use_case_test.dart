import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart'
    show AliasEntity, LinksEntity;
import 'package:main/src/home/domain/repository/short_url_repository.dart';
import 'package:main/src/home/domain/use_case/get_aliases_use_case.dart'
    show GetAliasesUseCase;
import 'package:mocktail/mocktail.dart';

class _MockShortUrlRepository extends Mock implements ShortUrlRepository {}

void main() {
  late ShortUrlRepository repository;
  late GetAliasesUseCase useCase;

  setUp(() {
    repository = _MockShortUrlRepository();
    useCase = GetAliasesUseCase(repository);
  });

  test('should return list of aliases when call use case', () async {
    final alias = AliasEntity("", LinksEntity("", ""));
    //  Given
    when(() => repository.getAliases()).thenAnswer((_) async => [alias]);
    //  When
    final result = await useCase(NoParams.noParams);
    //  Then
    expect(result.isRight(), true);
    verify(() => repository.getAliases()).called(1);
  });
}
