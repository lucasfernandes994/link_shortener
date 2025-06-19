import 'package:main/src/home/domain/entity/alias_entity.dart';

sealed class HomeState {
  final List<AliasEntity> alias;

  HomeState(this.alias);
}

class HomeInitial extends HomeState {
  HomeInitial(super.alias);
}

class HomeLoadingState extends HomeState {
  HomeLoadingState(super.alias);
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message, super.alias);
}

class DataState extends HomeState {
  DataState(super.alias);
}
