import 'package:core/core.dart' show NoParams;
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart';
import 'package:main/src/home/domain/use_case/get_aliases_use_case.dart';
import 'package:main/src/home/domain/use_case/remove_alias_use_case.dart';
import 'package:main/src/home/domain/use_case/short_url_use_case.dart';
import 'package:main/src/home/presenter/home_state.dart';

@injectable
class HomeController {
  final ShortUrlUseCase _shortUrlUseCase;
  final GetAliasesUseCase _getAliasesUseCase;
  final RemoverAliasUseCase _removerAliasUseCase;

  HomeController(this._shortUrlUseCase, this._getAliasesUseCase, this._removerAliasUseCase);

  final _state = ValueNotifier<HomeState>(HomeInitial([]));

  ValueListenable<HomeState> get state => _state;

  var _aliases = List<AliasEntity>.empty(growable: true);

  Future<void> init() async {
    final result = await _getAliasesUseCase(NoParams.noParams);

    result.fold((l) => print(l.message), (r) => _onSuccess(r));
  }

  Future<void> short(String url) async {
    _state.value = HomeLoadingState(_aliases);

    final result = await _shortUrlUseCase(url);

    result.fold(
      (l) => _state.value = HomeErrorState(l.message, _aliases),
      (r) => _onSuccess([r]),
    );
  }

  Future<void> remove(AliasEntity alias) async {
    final result = await _removerAliasUseCase(alias);

    result.fold(
      (l) => _state.value = HomeErrorState(l.message, _aliases),
      (r) {
        _aliases.clear();
         _onSuccess(r);
      },
    );
  }

  void _onSuccess(List<AliasEntity> aliases) {
    aliases.addAll(_aliases);
    _aliases = aliases;
    _state.value = DataState(_aliases);
  }
}
