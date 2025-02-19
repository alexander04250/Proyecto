import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthController {
  final String _apiUrl = 'http://192.168.0.17:8080';
  final Map<String, String> _headers = {'Content-Type': 'application/json'};

  // Método para iniciar sesión
  Future<bool> login(
      BuildContext context, String email, String password) async {
    try {
      // Mostrar indicador de carga
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      final response = await http.post(
        Uri.parse('$_apiUrl/auth/login'),
        headers: _headers,
        body: jsonEncode({'correo': email, 'contraseña': password}),
      );

      // Verificar si el contexto sigue montado antes de usarlo
      if (context.mounted) {
        Navigator.pop(context); // Cerrar el indicador de carga
      }

      if (response.statusCode == 200) {
        // Si el login es exitoso, mostrar mensaje de éxito
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Inicio de sesión exitoso')),
          );
        }
        return true; // Credenciales válidas
      } else {
        // Si las credenciales son incorrectas, mostrar el error
        final errorBody = jsonDecode(response.body);
        String errorMessage =
            errorBody['message'] ?? 'Usuario o contraseña incorrectos';

        // Mostrar el mensaje de error si el contexto sigue montado
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
        return false; // Credenciales inválidas
      }
    } catch (e) {
      // Manejo de errores de red o inesperados
      if (context.mounted) {
        Navigator.pop(context); // Cerrar el indicador de carga
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de red: $e')),
        );
      }
      return false;
    }
  }
}
