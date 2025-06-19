
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart';

abstract interface  class ShortUrlRepository {

  Future<Either<Failure, AliasEntity>> shortUrl(String url);
}