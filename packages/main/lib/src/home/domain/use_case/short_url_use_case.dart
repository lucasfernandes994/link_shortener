import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart';
import 'package:main/src/home/domain/repository/short_url_repository.dart';

@injectable
class ShortUrlUseCase implements BaseUseCase<AliasEntity, String> {
  final ShortUrlRepository _repository;

  const ShortUrlUseCase(this._repository);

  @override
  Future<Either<Failure, AliasEntity>> call(String params) async {
    if (params.isEmpty) {
      return Left(IllegalArgumentFailure("Url cannot be empty."));
    }

    if (!isLinkValid(params)) {
      return Left(IllegalArgumentFailure("Invalid url."));
    }

    final result = await _repository.shortUrl(params);
    result.fold(
      (f) => print(f),
      (data) async => await _repository.saveAlias(data),
    );

    return result;
  }

  bool isLinkValid(String url) {
    final regex = RegExp(
      r'^(https?:\/\/)?(www\.)?([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,}(:\d+)?(\/\S*)?$',
    );
    return regex.hasMatch(url);
  }
}
