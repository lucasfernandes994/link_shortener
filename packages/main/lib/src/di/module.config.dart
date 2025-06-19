// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:core/core.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../home/data/repository/short_url_repository_impl.dart' as _i280;
import '../home/domain/repository/short_url_repository.dart' as _i743;
import '../home/domain/use_case/get_aliases_use_case.dart' as _i1049;
import '../home/domain/use_case/remove_alias_use_case.dart' as _i568;
import '../home/domain/use_case/short_url_use_case.dart' as _i287;
import '../home/presenter/home_controller.dart' as _i636;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i743.ShortUrlRepository>(
      () => _i280.ShortUrlRepositoryImpl(
        gh<_i494.ApiEngineer>(),
        gh<_i494.UriFactory>(),
        gh<_i494.LocalStorage>(),
      ),
    );
    gh.factory<_i287.ShortUrlUseCase>(
      () => _i287.ShortUrlUseCase(gh<_i743.ShortUrlRepository>()),
    );
    gh.factory<_i1049.GetAliasesUseCase>(
      () => _i1049.GetAliasesUseCase(gh<_i743.ShortUrlRepository>()),
    );
    gh.factory<_i568.RemoverAliasUseCase>(
      () => _i568.RemoverAliasUseCase(gh<_i743.ShortUrlRepository>()),
    );
    gh.factory<_i636.HomeController>(
      () => _i636.HomeController(
        gh<_i287.ShortUrlUseCase>(),
        gh<_i1049.GetAliasesUseCase>(),
        gh<_i568.RemoverAliasUseCase>(),
      ),
    );
    return this;
  }
}
