import 'package:flutter/material.dart';
import 'package:tarea1_application/screens/ej11.dart';
import 'package:tarea1_application/screens/ej12.dart';
import 'package:tarea1_application/screens/ej13.dart';
import 'package:tarea1_application/screens/ej14.dart';
import 'package:tarea1_application/screens/ej15.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú principal - Ejercicios')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildNavButton(context, 'Ejercicio 11 - Caja supermercado', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Ejercicio11View()));
            }),
            _buildNavButton(context, 'Ejercicio 12 - Vuelto óptimo', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Ejercicio12View()));
            }),
            _buildNavButton(context, 'Ejercicio 13 - Año bisiesto', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => DeterminarAnioBisiesto()));
            }),
            _buildNavButton(context, 'Ejercicio 14 - Número perfecto', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => DeterminarNumeroPerfecto()));
            }),
            _buildNavButton(context, 'Ejercicio 15 - Pesajes', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Ej15Screen()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String label, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
        child: Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
