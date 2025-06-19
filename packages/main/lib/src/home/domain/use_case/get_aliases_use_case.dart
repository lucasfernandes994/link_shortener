import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart';
import 'package:main/src/home/domain/repository/short_url_repository.dart';

@injectable
class GetAliasesUseCase implements BaseUseCase<List<AliasEntity>, NoParams> {
  final ShortUrlRepository _repository;

  const GetAliasesUseCase(this._repository);

  @override
  Future<Either<Failure, List<AliasEntity>>> call(NoParams params) async {
    final result = await _repository.getAliases();
    return Right(result);
  }
}
