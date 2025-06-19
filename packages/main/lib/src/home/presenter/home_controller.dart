import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart';
import 'package:main/src/home/domain/use_case/short_url_use_case.dart';
import 'package:main/src/home/presenter/home_state.dart';

@injectable
class HomeController {
  final ShortUrlUseCase _shortUrlUseCase;

  HomeController(this._shortUrlUseCase);

  final _state = ValueNotifier<HomeState>(HomeInitial([]));

  ValueListenable<HomeState> get state => _state;

  var _alias = List<AliasEntity>.empty();

  Future<void> init() async {}

  Future<void> short(String url) async {
    _state.value = HomeLoadingState(_alias);

    final result = await _shortUrlUseCase(url);

    result.fold(
      (l) => _state.value = HomeErrorState(l.message, _alias),
      (r) => _onSuccess(r),
    );
  }

  void _onSuccess(AliasEntity alias) {
    _alias = [alias, ..._alias];
    _state.value = DataState(_alias);
  }
}
