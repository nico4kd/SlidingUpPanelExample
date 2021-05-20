import 'dart:convert';

class PtoRefData {
  String? nombre;
  String? direccion;
  double? latitud;
  double? longitud;

  PtoRefData({this.nombre, this.direccion, this.latitud, this.longitud});

  factory PtoRefData.fromMap(Map<String, dynamic> parsedJson) {
    return PtoRefData(
        nombre: parsedJson['NOMBRE'] as String,
        direccion: parsedJson['CALLE'] as String,
        latitud: parsedJson['LATITUD'],
        longitud: parsedJson['LONGITUD']);
  }

  factory PtoRefData.fromJson(String source) => PtoRefData.fromMap(jsonDecode(source));

  Map<String, dynamic> toMap() {
    return {
      'NOMBRE': nombre,
      'CALLE': direccion,
      'LATITUD': latitud,
      'LONGITUD': longitud,
    };
  }

  String toJson() => json.encode(toMap());

  static List<PtoRefData> parseJson(String body) {
    final List parsed = jsonDecode(body);
    return parsed.map<PtoRefData>((entrada) => PtoRefData.fromMap(entrada)).toList();
  }
}
