// Disponemos de una máquina que puede dar vuelto con 5 tipos de monedas distintas: $2, $1, $0.50, $0.25, $0.10.
// Realizar el programa que, dados el precio del artículo y la cantidad entregada por el consumidor, nos indique el vuelto a entregar empleando el menor número posible de monedas.

import 'package:flutter/material.dart';

class Ejercicio12View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Ejercicio12State();
}

class _Ejercicio12State extends State<Ejercicio12View> {
  // { Centavos: Cantidad }
  Map<int, int> vuelto = {
    200: 0,
    100: 0,
    50: 0,
    25: 0,
    10: 0
  };

  // Controlador
  final valueCtrl = TextEditingController();

  void setVueltoCants(double value) {
    int precioCents = (value * 100).round();

    setState(() {
      for (int cents in vuelto.keys) {
        vuelto[cents] = precioCents ~/ cents;
        precioCents %= cents;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double spaceSize = 12;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            Text('Ingrese la cantidad a transformar: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),

            SizedBox(height: spaceSize,),

            TextField(
              controller: valueCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Valor (\$)'
              ),
            ),

            SizedBox(height: spaceSize,),

            ElevatedButton(
              onPressed: () => {
                setVueltoCants(double.tryParse(valueCtrl.text) ?? 0)
              },
              child: Text('Calcular')
            ),

            SizedBox(height: spaceSize,),

            Text('Monedas de \$2: ${vuelto[200]}'),
            Text('Monedas de \$1: ${vuelto[100]}'),
            Text('Monedas de \$0.50: ${vuelto[50]}'),
            Text('Monedas de \$0.25: ${vuelto[25]}'),
            Text('Monedas de \$0.10: ${vuelto[10]}'),
          ],
        ),
      ),
    );
  }
  
}