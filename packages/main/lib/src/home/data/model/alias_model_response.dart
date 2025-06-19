import 'package:main/src/home/domain/entity/alias_entity.dart';

class AliasModelResponse extends AliasEntity {
  AliasModelResponse(super.alias, super.links);

  factory AliasModelResponse.fromJson(Map<String, dynamic> json) {
    return AliasModelResponse(
      json['alias'],
      LinksModelResponse.fromJson(json['_links'] ?? {}),
    );
  }
}

class LinksModelResponse extends LinksEntity {
  LinksModelResponse(super.self, super.short);

  factory LinksModelResponse.fromJson(Map<String, dynamic> json) {
    return LinksModelResponse(json['self'] ?? '', json['short'] ?? '');
  }
}
