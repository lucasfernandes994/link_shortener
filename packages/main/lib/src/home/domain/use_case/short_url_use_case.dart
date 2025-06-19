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

    if (!_isValidUrl(params)) {
      return Left(IllegalArgumentFailure("Invalid url."));
    }

    return _repository.shortUrl(params);
  }

  bool _isValidUrl(String input) {
    final uri = Uri.tryParse(input);
    return uri != null;
  }
}
