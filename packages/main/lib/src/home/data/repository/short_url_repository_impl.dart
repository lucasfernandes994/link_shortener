import 'dart:convert';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:main/src/home/data/model/alias_model_response.dart';
import 'package:main/src/home/data/model/short_url_request.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart';
import 'package:main/src/home/domain/repository/short_url_repository.dart';
import 'package:main/src/utils/constants.dart';

@Injectable(as: ShortUrlRepository)
class ShortUrlRepositoryImpl implements ShortUrlRepository {
  final ApiEngineer _apiEngineer;
  final UriFactory _uriFactory;
  final LocalStorage _localStorage;

  const ShortUrlRepositoryImpl(
    this._apiEngineer,
    this._uriFactory,
    this._localStorage,
  );

  @override
  Future<Either<Failure, AliasEntity>> shortUrl(String url) async {
    try {
      final uri = _uriFactory.create(Constants.baseUrl, "/api/alias");
      final response = await _apiEngineer.postSafeRequest(
        uri,
        null,
        ShortUrlRequest(url).toRequest(),
      );
      final json = jsonDecode(response.body);

      return Right(AliasModelResponse.fromJson(json));
    } on Exception catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<bool> saveAlias(AliasEntity alias) async {
    final aliases = await getAliases();

    aliases.add(alias);

    final json = jsonEncode(aliases);
    return await _localStorage.saveString(Constants.db, json);
  }

  @override
  Future<List<AliasEntity>> getAliases() async {
    final aliases = <AliasEntity>[];

    final source = await _localStorage.getString(Constants.db);

    if (source == null) {
      return aliases;
    }

    final json = jsonDecode(source);

    for (final alias in json) {
      aliases.add(AliasModelResponse.fromJson(alias));
    }

    return aliases;
  }

  @override
  Future<List<AliasEntity>> removeAlias(AliasEntity alias) async {
    final aliases = await getAliases();

    AliasEntity? foundItem;

    try {
      foundItem = aliases.firstWhere((element) => element.alias == alias.alias);
    } catch (e) {
      print(e);
    }

    if (foundItem == null) {
      return aliases;
    }

    aliases.remove(foundItem);

    final json = jsonEncode(aliases);
    await _localStorage.saveString(Constants.db, json);

    return getAliases();
  }
}
