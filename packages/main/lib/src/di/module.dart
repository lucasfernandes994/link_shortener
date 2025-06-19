import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'module.config.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureMainDependencies(GetIt getIt) => getIt.init();
