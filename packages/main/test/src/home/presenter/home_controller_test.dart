import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart';
import 'package:main/src/home/domain/use_case/get_aliases_use_case.dart';
import 'package:main/src/home/domain/use_case/remove_alias_use_case.dart';
import 'package:main/src/home/domain/use_case/short_url_use_case.dart';
import 'package:main/src/home/presenter/home_controller.dart';
import 'package:main/src/home/presenter/home_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAliasesUseCase extends Mock implements GetAliasesUseCase {}

class MockShortUrlUseCase extends Mock implements ShortUrlUseCase {}

class MockRemoverAliasUseCase extends Mock implements RemoverAliasUseCase {}

class MockAliasEntity extends Mock implements AliasEntity {}

void main() {
  late HomeController controller;
  late GetAliasesUseCase _getAliasesUseCase;
  late ShortUrlUseCase _shortUrlUseCase;
  late RemoverAliasUseCase _removerAliasUseCase;

  setUp(() {
    _getAliasesUseCase = MockGetAliasesUseCase();
    _shortUrlUseCase = MockShortUrlUseCase();
    _removerAliasUseCase = MockRemoverAliasUseCase();
    controller = HomeController(
      _shortUrlUseCase,
      _getAliasesUseCase,
      _removerAliasUseCase,
    );
  });

  test('should initializes with aliases successfully', () async {
    final aliases = [
      AliasEntity("google.com", LinksEntity("google.com", "google")),
    ];
    when(
      () => _getAliasesUseCase(NoParams.noParams),
    ).thenAnswer((_) async => Right(aliases));

    await controller.init();

    expect(controller.state.value, isA<DataState>());
    final state = controller.state.value as DataState;
    expect(state.aliases, aliases);

    verify(() => _getAliasesUseCase(NoParams.noParams)).called(1);
  });

  test('should handles error during initialization', () async {
    when(
      () => _getAliasesUseCase(NoParams.noParams),
    ).thenAnswer((_) async => Left(IllegalArgumentFailure("Error")));

    await controller.init();

    expect(controller.state.value, isNot(isA<DataState>()));
    verify(() => _getAliasesUseCase(NoParams.noParams)).called(1);
  });

  test('should shortens URL successfully', () async {
    final alias = AliasEntity(
      "google.com",
      LinksEntity("google.com", "google"),
    );
    when(
      () => _shortUrlUseCase("google.com"),
    ).thenAnswer((_) async => Right(alias));

    await controller.short("google.com");

    expect(controller.state.value, isA<DataState>());
    final state = controller.state.value as DataState;
    expect(state.aliases, contains(alias));

    verify(() => _shortUrlUseCase("google.com")).called(1);
  });

  test('should handles error during URL shortening', () async {
    when(
      () => _shortUrlUseCase("google.com"),
    ).thenAnswer((_) async => Left(IllegalArgumentFailure("Error")));

    await controller.short("google.com");

    expect(controller.state.value, isA<HomeErrorState>());
    final state = controller.state.value as HomeErrorState;
    expect(state.message, "Error");

    verify(() => _shortUrlUseCase("google.com")).called(1);
  });

  test('should removes alias successfully', () async {
    final alias = AliasEntity(
      "google.com",
      LinksEntity("google.com", "google"),
    );
    final updatedAliases = <AliasEntity>[];
    when(
      () => _removerAliasUseCase(alias),
    ).thenAnswer((_) async => Right(updatedAliases));

    await controller.remove(alias);

    expect(controller.state.value, isA<DataState>());
    final state = controller.state.value as DataState;
    expect(state.aliases, isEmpty);

    verify(() => _removerAliasUseCase(alias)).called(1);
  });

  test('should handles error during alias removal', () async {
    final alias = AliasEntity(
      "google.com",
      LinksEntity("google.com", "google"),
    );
    when(
      () => _removerAliasUseCase(alias),
    ).thenAnswer((_) async => Left(IllegalArgumentFailure("Error")));

    await controller.remove(alias);

    expect(controller.state.value, isA<HomeErrorState>());
    final state = controller.state.value as HomeErrorState;
    expect(state.message, "Error");

    verify(() => _removerAliasUseCase(alias)).called(1);
  });
}
