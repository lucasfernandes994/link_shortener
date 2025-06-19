import 'package:core/core.dart';
import 'package:dartz/dartz.dart' show Either, Right;
import 'package:injectable/injectable.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart';
import 'package:main/src/home/domain/repository/short_url_repository.dart';

@injectable
class RemoverAliasUseCase implements BaseUseCase<List<AliasEntity>, AliasEntity> {
  final ShortUrlRepository _repository;

  const RemoverAliasUseCase(this._repository);

  @override
  Future<Either<Failure, List<AliasEntity>>> call(AliasEntity params) async {
    final result = await _repository.removeAlias(params);
    return Right(result);
  }
}
