import 'package:main/src/home/domain/entity/alias_entity.dart';

sealed class HomeState {
  final List<AliasEntity> aliases;

  HomeState(this.aliases);
}

class HomeInitial extends HomeState {
  HomeInitial(super.aliases);
}

class HomeLoadingState extends HomeState {
  HomeLoadingState(super.aliases);
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message, super.aliases);
}

class DataState extends HomeState {
  DataState(super.aliases);
}
