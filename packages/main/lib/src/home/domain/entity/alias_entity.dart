
class AliasEntity {
  final String alias;
  final LinksEntity links;

  AliasEntity(this.alias, this.links);
}

class LinksEntity {
  final String self;
  final String short;

  LinksEntity(this.self, this.short);
}