class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  // Método para crear un idioma a partir de un mapa (ej. JSON)
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      code: json['code'],
      name: json['name'],
    );
  }

  // Método para convertir un idioma a un mapa (ej. para enviar en una solicitud)
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}