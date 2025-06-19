class AliasEntity {
  final String alias;
  final LinksEntity links;

  AliasEntity(this.alias, this.links);

  Map<String, dynamic> toJson() => {"alias": alias, "_links": links.toJson()};
}

class LinksEntity {
  final String self;
  final String short;

  LinksEntity(this.self, this.short);

  Map<String, dynamic> toJson() => {"self": self, "short": short};
}
