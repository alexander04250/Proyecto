import 'package:flutter/material.dart';
import 'language_selection_screen.dart';
import 'progress_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
        centerTitle: true,
      ),
      body: Center(
        // Centra el contenido vertical y horizontalmente
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título encima de la imagen
            Text(
              'Welcome!', // Cambié a "Welcome"
              style: TextStyle(
                fontFamily: 'Matemasie',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Color más visible
              ),
            ),
            SizedBox(height: 20),
            // Imagen centrada
            Image.asset(
              'assets/cat.png',
              height: 150, // Ajusta el tamaño según sea necesario
              width: 150,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 40),
            // Botón para continuar a la selección de idioma con un color mejorado
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LanguageSelectionScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                backgroundColor: Colors.blue, // Color de fondo más visible
              ),
              child: Text(
                'Continuar lección',
                style: TextStyle(
                    fontSize: 18, color: Colors.white), // Mejor contraste
              ),
            ),
            SizedBox(height: 16),
            // Botón para ver el progreso con un color mejorado
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProgressScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                backgroundColor: Colors.green, // Color de fondo más visible
              ),
              child: Text(
                'Ver Progreso',
                style: TextStyle(
                    fontSize: 18, color: Colors.white), // Mejor contraste
              ),
            ),
          ],
        ),
      ),
    );
  }
}
