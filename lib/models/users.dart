class User {
  final String username;
  final String email;

  User({required this.username, required this.email});

  // Método para crear un usuario a partir de un mapa (ej. JSON)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
    );
  }

  // Método para convertir un usuario a un mapa (ej. para enviar en una solicitud)
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
    };
  }
}