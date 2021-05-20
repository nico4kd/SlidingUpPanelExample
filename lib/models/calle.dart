import 'dart:convert';

class Calles {
  String? localidad;
  String? calle;
  int? desde;
  int? hasta;
  double? latitud;
  double? longitud;

  Calles({this.localidad, this.calle, this.desde, this.hasta, this.latitud, this.longitud});

  factory Calles.fromMap(Map<String, dynamic> parsedJson) {
    return Calles(
        localidad: parsedJson['LOCALIDAD'] ?? '',
        desde: parsedJson['FROMLEFT'],
        hasta: parsedJson['TORIGHT'],
        calle: parsedJson['CALLE'] ?? '',
        latitud: parsedJson['LATITUD'],
        longitud: parsedJson['LONGITUD']);
  }

  factory Calles.fromJson(String source) => Calles.fromMap(jsonDecode(source));

  static List<Calles> parseJson(String body) {
    final List parsed = jsonDecode(body);
    return parsed.map<Calles>((entrada) => Calles.fromMap(entrada)).toList();
  }
}
