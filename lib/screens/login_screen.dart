import 'package:flutter/material.dart';
import 'Controller/auth_controller.dart';
import 'register_screen.dart';
import 'welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'Bienvenido',
                style: TextStyle(
                  fontFamily: 'Matemasie',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  // Validaciones
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Por favor ingresa tu email y contraseña')),
                    );
                    return;
                  }

                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                      .hasMatch(emailController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Por favor ingresa un email válido')),
                    );
                    return;
                  }

                  // Intentar iniciar sesión
                  bool loginExitoso = await authController.login(
                    context,
                    emailController.text,
                    passwordController.text,
                  );

                  // Verificar si el contexto sigue montado antes de usarlo
                  if (!context.mounted) return;

                  if (loginExitoso) {
                    // Mostrar mensaje de inicio de sesión exitoso
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Inicio de sesión exitoso')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  } else {
                    // Si el login falló, mostrar mensaje de error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Usuario o contraseña incorrectos')),
                    );
                  }
                },
                child: Text('Iniciar Sesión'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
