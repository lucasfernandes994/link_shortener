import 'package:flutter_test/flutter_test.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart'
    show AliasEntity, LinksEntity;
import 'package:main/src/home/domain/repository/short_url_repository.dart';
import 'package:main/src/home/domain/use_case/remove_alias_use_case.dart';
import 'package:mocktail/mocktail.dart';

class _MockShortUrlRepository extends Mock implements ShortUrlRepository {}

void main() {
  late ShortUrlRepository repository;
  late RemoverAliasUseCase useCase;

  setUp(() {
    repository = _MockShortUrlRepository();
    useCase = RemoverAliasUseCase(repository);
  });

  test('should remove an alias with success when call use case', () async {
    final alias = AliasEntity("", LinksEntity("", ""));
    //  Given
    when(() => repository.removeAlias(alias)).thenAnswer((_) async => []);
    //  When
    final result = await useCase(alias);
    //  Then
    expect(result.isRight(), true);
    verify(() => repository.removeAlias(alias)).called(1);
  });
}
