import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.0.17:8080';

  // Método privado para hacer solicitudes POST
  static Future<Map<String, dynamic>> _postRequest(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final errorMessage =
            jsonDecode(response.body)['error'] ?? 'Unknown error';
        throw Exception('Failed to complete request: $errorMessage');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Método para iniciar sesión
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    return await _postRequest(
        '/auth/login', {'correo': email, 'contraseña': password});
  }

  // Método para registrar un usuario
  static Future<Map<String, dynamic>> register(
      String email, String password) async {
    return await _postRequest(
        '/auth/register', {'correo': email, 'contraseña': password});
  }
}
