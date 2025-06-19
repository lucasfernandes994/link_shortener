// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import '../data/enginner/api_engineer.dart' as _i713;
import '../data/enginner/api_engineer_impl.dart' as _i249;
import '../data/http/http.dart' as _i6;
import '../utils/uri_factory.dart' as _i456;
import 'module.dart' as _i946;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i6.Http>(() => _i6.Http());
    gh.factory<_i974.Logger>(() => registerModule.logger);
    gh.factory<_i456.UriFactory>(() => _i456.UriFactory());
    gh.factory<_i713.ApiEngineer>(
      () => _i249.ApiEngineerImpl(gh<_i6.Http>(), gh<_i974.Logger>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i946.RegisterModule {}
