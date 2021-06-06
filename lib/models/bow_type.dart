
class BowType {
  final String id;
  final String bowType;

  BowType._(this.id, this.bowType);

  static createCompound() {
    return new BowType._("compound", "Compound");
  }
}