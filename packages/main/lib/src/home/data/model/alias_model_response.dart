import 'package:main/src/home/domain/entity/alias_entity.dart';

class AliasModelResponse extends AliasEntity {
  AliasModelResponse(super.alias, super.links);

  factory AliasModelResponse.fromJson(Map<String, dynamic> json) {
    return AliasModelResponse(
      json['alias'],
      List<String>.from(json["links"].map((x) => x)),
    );
  }
}
