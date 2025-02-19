import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progreso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Frase introductoria sobre el progreso
            Text(
              'Aquí podrás ver el progreso de cada lección o actividad realizada.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40), // Espacio después de la frase
            _buildProgressItem('Inglés', 0.0, Colors.blue), // Progreso en 0
            SizedBox(height: 30), // Espacio entre elementos de progreso
            _buildProgressItem('Francés', 0.0, Colors.red), // Progreso en 0
            SizedBox(height: 30), // Espacio entre elementos de progreso
            _buildProgressItem('Japonés', 0.0, Colors.green), // Progreso en 0
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(String language, double progress, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            language,
            style: TextStyle(fontSize: 24),
          ),
        ),
        SizedBox(width: 16), // Espacio entre el texto y el indicador
        CircularProgressIndicator(
          value: progress,
          color: color,
          backgroundColor: Colors.grey[300],
        ),
        SizedBox(width: 16), // Espacio entre el indicador y el porcentaje
        Text('${(progress * 100).toInt()}%'),
      ],
    );
  }
}
