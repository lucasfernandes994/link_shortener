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
      return Left(IllegalArgumentFailure("Alias cannot be empty."));
    }

    return _repository.shortUrl(params);
  }
}
