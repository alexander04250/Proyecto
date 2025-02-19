import 'package:flutter/material.dart';

// Pantalla de Selección de Idioma
class LanguageSelectionScreen extends StatelessWidget {
  final List<String> languages = [
    'Inglés',
    'Francés',
    'Alemán',
    'Italiano',
    'Portugués',
    'Mandarín (Chino)',
    'Japonés',
    'Coreano'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selección de idioma'),
      ),
      body: ListView.separated(
        itemCount: languages.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(languages[index]),
            onTap: () {
              // Al seleccionar un idioma, navegar a la pantalla de "trabajando"
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LanguageInProgressScreen(language: languages[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LanguageInProgressScreen extends StatelessWidget {
  final String language;

  const LanguageInProgressScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$language en progreso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Estamos trabajando en nuevas lecciones para este idioma!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Pronto podrás comenzar a aprender $language. ¡Gracias por tu paciencia!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                    context); // Regresar a la pantalla de selección de idioma
              },
              child: Text('Volver a Selección de Idioma'),
            ),
          ],
        ),
      ),
    );
  }
}
