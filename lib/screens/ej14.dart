import 'package:flutter/material.dart';

class DeterminarNumeroPerfecto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeterminarNumeroPerfectoPageState();
}

class _DeterminarNumeroPerfectoPageState
    extends State<DeterminarNumeroPerfecto> {
  final numeroCtrl = TextEditingController();
  bool esPerfecto = false;
  String respuesta = "";
  String divisoresTexto = "";

  void procesarNumero() {
    final numero = int.tryParse(numeroCtrl.text) ?? 0;
    !esPerfecto;

    int suma = 0;
    List<int> divisores = [];

    setState(() {
      for (int i = 1; i < numero; i++) {
        if (numero % i == 0) {
          suma += i;
          divisores.add(i);
        }
      }

      esPerfecto = (suma == numero);
      divisoresTexto = "Divisores: ${divisores.join(" + ")} = $suma";

      if (esPerfecto) {
        respuesta = "El número $numero es un número perfecto";
      } else {
        respuesta = "El número $numero no es un número perfecto";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comprobar número bisiesto'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ingrese el número que desea comprobar si es o no perfecto',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            TextField(
              controller: numeroCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Número',
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(onPressed: procesarNumero, child: Text('Comprobar')),
            SizedBox(height: 12),
            Text(respuesta),
            SizedBox(height: 8),
            Text(
              ' $divisoresTexto',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
