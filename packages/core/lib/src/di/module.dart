import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'module.config.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureCoreDependencies(GetIt getIt) => getIt.init();

@module
abstract class RegisterModule {
  Logger get logger => Logger();
}
