import 'dart:convert';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:main/src/home/data/model/alias_model_response.dart';
import 'package:main/src/home/data/model/short_url_request.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart';
import 'package:main/src/home/domain/repository/short_url_repository.dart';

@Injectable(as: ShortUrlRepository)
class ShortUrlRepositoryImpl implements ShortUrlRepository {
  final _baseUrl = "https://url-shortener-nu.herokuapp.com";
  final ApiEngineer _apiEngineer;
  final UriFactory _uriFactory;

  const ShortUrlRepositoryImpl(this._apiEngineer, this._uriFactory);

  @override
  Future<Either<Failure, AliasEntity>> shortUrl(String url) async {
    final uri = _uriFactory.create(_baseUrl, "/api/alias");
    final response = await _apiEngineer.postSafeRequest(
      uri,
      null,
      ShortUrlRequest(url).toRequest(),
    );
    final json = jsonDecode(response.body);

    return Right(AliasModelResponse.fromJson(json));
  }
}
