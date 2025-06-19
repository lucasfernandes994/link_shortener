import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:main/main.dart';

final locator = GetIt.instance;

void setupLocator() {
  configureCoreDependencies(locator);
  configureMainDependencies(locator);
}
