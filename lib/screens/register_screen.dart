import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importar la pantalla de login

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla de inicio de sesión
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registro',
              style: TextStyle(
                fontFamily: 'Matemasie',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Por favor, completa todos los campos.')),
                  );
                  return;
                }

                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                    .hasMatch(emailController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Por favor ingresa un email válido.')),
                  );
                  return;
                }

                // Mostrar indicador de carga
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  },
                );

                try {
                  var response = await http.post(
                    Uri.parse('http://192.168.0.17:8080/auth/register'),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode({
                      'correo': emailController.text,
                      'contraseña': passwordController.text,
                    }),
                  );

                  // Verificar que el contexto sigue montado
                  if (!context.mounted) return;

                  Navigator.pop(context); // Eliminar el indicador de carga

                  if (response.statusCode == 200) {
                    // Registro exitoso
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registro exitoso')),
                    );

                    // Regresar a la pantalla de login después del registro exitoso
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  } else {
                    // Error en la respuesta
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${response.body}')),
                    );
                  }
                } catch (e) {
                  // Error al conectar con el servidor
                  if (!context.mounted) return;
                  Navigator.pop(context); // Eliminar el indicador de carga

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Error al conectar con el servidor: $e')),
                  );
                }
              },
              child: Text('Registrar Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
