enum Panels {
  inicio,
  direccion,
}

extension ParseToString on Panels {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
